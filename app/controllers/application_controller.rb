class ApplicationController < ActionController::Base
    include Pagy::Backend

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_current_user , if: :user_signed_in?
    before_action :admin? , if: :user_signed_in?
  
    
 
    
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

    private

    def set_current_user
      Current.user = current_user
    end
    
    def admin?
      Current.user.admin
    end
  
    helper_method :admin?
    
  end