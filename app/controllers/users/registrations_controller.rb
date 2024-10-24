class Users::RegistrationsController < Devise::ApplicationController
    before_action :check_admin, only:[:new, :create]
    before_action :configure_permitted_parameters, if: :devise_controller?

    private

    def check_admin
        unless current_user&.admin?
            redirect_to root_path, alert: 'No tiene permiso para crear un usuario '
        end
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys:[:email, :password, :password_confirmation])
    end
end
