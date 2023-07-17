class RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(sign_up_params)

    return render json: { success: true, message: I18n.t('json.user_created_success') } if user.save

    render json: { success: false, errors: user.errors }, status: :unprocessable_entity
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def authenticate_token!
    authorization_header = request.headers['Authorization']

    return render json: { error: 'Missing token' }, status: :unauthorized if authorization_header == 'null'

    @current_user = User.find_by(authentication_token: authorization_header)
  end
end
