class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def after_sign_in_path_for(resource)
    if current_user.is_deleted == true
      sign_out
      new_user_registration_path
    else
      new_record_path(resource)
    end
  end



  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :name])
  end
end
