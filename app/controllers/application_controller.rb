class ApplicationController < ActionController::Base
    helper_method :get_active_user, :get_vehicle

    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :address, :phone_no, :email, :password, :password_confirmation)}

        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :address, :phone_no, :email, :password, :current_password)}
    end

    private
    def get_active_user
        if user_signed_in?
            return User.find_by(id:current_user.id)
        else
            return nil
        end
    end

    def get_vehicle(vehicle_id)
        return Vehicle.find_by(id:vehicle_id)
    end

end
