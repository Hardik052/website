class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[email password password_confirmation address
                                               province_id])
  end

  def after_sign_out_path_for(scope)
    root_path
  end

  def create_cart
    return unless current_user && !current_user.cart

    current_user.create_cart
  end
end
