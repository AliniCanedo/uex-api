class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!

  def create
    user = User.new(sign_up_params)  

    return render json: { success: true, message: 'Usuário criado com sucesso' } if user.save

    render json: { success: false, errors: user.errors }, status: :unprocessable_entity
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
