class UsersController < ApplicationController
  def show
    @user=User.find(params[:id])
    @followings=@user.followings
    @followers=@user.followers
  end
  def index
    @users=User.all
  end
end
