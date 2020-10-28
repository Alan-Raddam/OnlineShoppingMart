# Rails工程启动流程

**由于不同版本的rails启动方式有差别，本文以Linux版本的rails5为例进行分析**

首先，直接执行ruby/bin/rails。在其中：

```ruby
load Gem.activate_bin_path('railties', 'rails', version)
```

跳转到RALITIES_PATH/bin/rails。在其中require "rails/cli"，跳转到/lib/rails/cli.rb。后者执行

```ruby
Rails::ScriptRailsLoader.exec_script_rails!
```

进入到script_rails_loader.rb中，调用exec_script_rails!方法，判定当前是否在应用程序目录下。如果在rails app目录下，加载AppLoader并使用exec_app启动应用，否则进入新建app的判断分支。

由于我们已经建立好了rails app，Rails::AppLoader:exec_app将会逐级向上查找。在找到app后，获取APP_ROOT_PATH，解析APP_PATH，并且执行rails/app_loader.rb。

该文件先后从APP_PATH/config/application和APP_PATH/config/boot中加载配置文件，最后require rails /command。其中，config/boot文件，是通过Bundler.setup将Gemfile中的gem路径添加到加载路径。

随后，在rails/command.rb中解析命令，由于我们用的是rails s，被跳转到server分支，调用server方法。

server方法首先设置用户应用程序目录，然后加载Rails::Server模块，加载APP_PATH，读取config/application.rb。在该rb中，require "rails/all"和我们自己的应用程序类，最后使用start方法启动服服务器。

start方法进行一些处理，然后直接进入父类的start方法中，通过Rack::Builder和Rack::Handler创建app和选择服务器。wrapped_app方法通过调用app方法创建应用程序实例，并调用build_app方法加载中间件。

最后，调用server方法选择server，使用server.run启动服务器。

具体的创建流程为：调用Rack::Builder.parse_file，解析config.ru，执行config.ru中的代码并且返回app对象。随后，返回到server方法中，选到puma服务器，通过try_require加载。由于在config/boot.rb中的文件已经通过Bundler.setup加载了所有路径，最终get方法会返回Rack::Hander::Puma类。

随后，server方法执行server.run,srapped_App,options,&blk等方法，这些类都是启动puma的操作，使得puma进入监听状态。



