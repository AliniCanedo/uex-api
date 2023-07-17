class UsersController < ApplicationController
  def show
    render json: { user: { name: @current_user.name, email: @current_user.email } }
  end

  def update    
    user = User.find(@current_user.id)

    user.update(user_params)

    return render json: { message: I18n.t('json.user_update_success') } if user.update(user_params)

    render json: { error: I18n.t('json.user_update_error') }, status: :unprocessable_entity
  end

  def destroy
    user = User.find(@current_user.id)

    user.destroy

    return render json: { message: I18n.t('json.user_destroy_success') } if user.destroy

    render json: { error: I18n.t('json.user_destroy_error') }, status: :unprocessable_entity
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
