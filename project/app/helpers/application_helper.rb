module ApplicationHelper
  def userisadmin
    unless user_signed_in?
      redirect_to new_user_session_path
      return
    end
    unless current_user.isadmin
      flash[:alert]="没有权限进行此操作"
      redirect_to root_path
    end
  end

  def useriscustomer
    unless user_signed_in?
      redirect_to new_user_session_path
      return
    end
    if current_user.isadmin
      flash[:alert]="管理员不能执行此操作"
      redirect_to root_path
    end
  end

  def usersignedin
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def isadmin?
    if user_signed_in? && current_user.isadmin
      return true
    end
    false
  end

  def iscustomer?
    if (user_signed_in?) && !(current_user.isadmin)
      return true
    end
    return false
  end

end
