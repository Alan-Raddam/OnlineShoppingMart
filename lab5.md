## gem包总结                 

                                                   宫元      18373563
* ActiveJob: 规划一些不需要立刻返回给用户结果的，耗时较长的任务组成一个队列一个接一个执行，或者规划一些定期的任务，例如图片处理，垃圾清理等。本身像是一个”事件管理器“
* ActiveModel:对应MVC模型中的M，封装了实体（模型）的数据
* ActiveRecord：往往和ActiveModel联合使用，负责其和数据库之间的交互. 程序员可以完全不用写sql命令，直接依赖ActiveRecord的方法，即可实现数据库的增删改查等操作以及方便地建立实体之间的”关系“。同时，ActiveRecord还有验证(Validations)的功能。
* ActiveSupport: rails需要的一些支持库集和工具类
* ActionMailer: 用于发送邮件
* ActionPack: 负责处理并回复web请求的流程控制。具体而言，负责联系主要是routers, ActionController和ActionView之间的关系，例如执行顺序，如何分发Action等。
* ActionController: 对应MVC模型中的Controller，和Model交互，进行逻辑处理，将数据交给ActionView进行渲染。
* ActionView: 对应MVC模型中的View，为视图的渲染模板，可以内嵌ruby代码。
* sqlite3: 数据库包
* scss-rails: 提供将scss编译为css样式表的功能。
* jbuilder: 方便地生成json字符串
* bcrypt: 方便地对密码进行加密存储。
* webpack: 负责”编译“和打包javascript，图片等asset中的资源。
* Turbolinks: 加快网页加载速度（避免每次重复的 head 其中的 css 与 javascript 标签的解析与加载时间）

