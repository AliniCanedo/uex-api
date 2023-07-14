class SessionsController < Devise::SessionsController
  respond_to :json

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))

    return render json: { message: 'Logout realizado com sucesso.' } if signed_out

    render json: { error: 'Erro ao realizar o logout.' }, status: :unprocessable_entity
  end

  private

  def respond_with(resource, _opts = {})
    render json: { token: resource.authentication_token }
  end

  def respond_to_on_destroy
    head :ok
  end
end
