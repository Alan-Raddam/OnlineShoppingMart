module ApplicationHelper
  def authenticate
    unless current_user
      flash[:notice]="您必须先登录"
      redirect_to new_user_session_path,notice: '请先登录'
    end
  end
end
