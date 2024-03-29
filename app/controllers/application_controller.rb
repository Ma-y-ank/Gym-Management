class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # def after_sign_in_path_for(resource)
  #    resource
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def only_admin
    unless current_user.admin?
      redirect_to root_path, notice: "You are not authorized to perform this action."
    end
  end
end
