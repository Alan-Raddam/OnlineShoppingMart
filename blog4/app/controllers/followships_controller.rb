class FollowshipsController < ApplicationController
  include ApplicationHelper
  skip_before_action :verify_authenticity_token, only: [:create,:destroy]
  before_action :authenticate, only:[:create,:destroy]

  def create
    @target=User.find(followship_params[:following_user_id])
    if current_user.nil? || followship_params[:user_id]!=current_user.id.to_s
      redirect_to user_path @target
      return
    end
    @followship=Followship.new followship_params
    @followship.save
    redirect_to user_path @target
  end

  def destroy
    @target=Followship.find(params[:id])
    @origin=User.find @target.following_user_id
    if current_user.nil? || @target.user_id!=current_user.id
      redirect_to user_path @origin
      return
    end
    @target.destroy
    @target.save
    redirect_to user_path @origin
  end

  private
  def followship_params
    params.require(:followship).permit(:user_id,:following_user_id)
  end

end
