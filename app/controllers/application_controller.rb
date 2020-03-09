class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?


 def who_login?
    if admin_signed_in?
      @header_login_name = "admin"
    else
      if user_signed_in?
        @header_login_name = "#{current_user.name}"
      end
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end


  def after_sign_in_path_for(resource)
  	root_path
  end
end
