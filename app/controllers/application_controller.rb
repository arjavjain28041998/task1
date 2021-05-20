class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :update_allowed_parameters, if: :devise_controller?
    protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password)}
    
  end
  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||

    if resource.preferred_page.present?
      preferred_page_path(resource)
    else
      super
    end
   
  end
end
