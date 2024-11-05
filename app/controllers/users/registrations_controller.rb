class Users::RegistrationsController < Devise::RegistrationsController
    # Saltar el filtro de Devise que bloquea usuarios autenticados en las acciones de registro
    skip_before_action :require_no_authentication, only: [:new, :create]
  
    before_action :check_admin, only: [:new, :create]
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authorize_admin!, only: [:new, :create]
  
    def new
      @resource = User.new
    end
  
    def create
      @resource = User.new(sign_up_params)
      if @resource.save
        redirect_to root_path, notice: 'Usuario creado con éxito'
      else
        render :new
      end
    end
  
    private
  
    def check_admin
      redirect_to root_path, alert: 'No tiene permiso para crear un usuario' unless current_user&.admin?
    end
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :role])
    end
  
    def authorize_admin!
      redirect_to root_path, alert: "No tienes permiso para crear usuarios" unless current_user&.admin?
    end
  
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end
  end