class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      sign_in(user)
      render json: { token: user.authentication_token, current_user: user }
    else
      render json: { errors: 'Credenciais inválidas' }, status: :unprocessable_entity
    end
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))

    return render json: { message: I18n.t('json.logout_success') } if signed_out

    render json: { error: I18n.t('json.logout_error') }, status: :unprocessable_entity
  end

  def respond_to_on_destroy
    head :ok
  end
end
