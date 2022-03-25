class RegistrationsController < Devise::RegistrationsController
    
    private
    def sign_up_params
        params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
    end

    def update_user_params
        params.require(:user).permit(:name, :username, :email, :password, :current_password)
    end
end
  