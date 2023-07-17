class ApplicationController < ActionController::API
  before_action :authenticate_token!, unless: :devise_controller?

  private

  def authenticate_token!
    authorization_header = request.headers['Authorization']&.gsub('Bearer ', '')
    return render json: { error: 'Missing token' }, status: :unauthorized if authorization_header.nil?

    @current_user = User.find_by(authentication_token: authorization_header)

    if @current_user.nil?
      render json: { error: 'User not found' }, status: :unauthorized
    else
      @current_user
    end
  end

  def devise_controller?
    self.class.to_s.start_with?('Devise::') || instance_of?(SessionsController)
  end
end
