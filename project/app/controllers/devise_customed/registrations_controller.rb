

class DeviseCustomed::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token,only: [:create]
  def new

    super
  end

  def create
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:phone])
    super
  end

  def update
    super
  end

end