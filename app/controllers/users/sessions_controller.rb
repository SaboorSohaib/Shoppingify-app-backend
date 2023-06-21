# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_for_database_authentication(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      token = JsonWebToken.encode({ sub: user.id })
      decoded_token = JsonWebToken.decode(token)
      @current_user = User.find_by(id: decoded_token['sub'])
      render json: { id: @current_user.id, name: @current_user.name, token: }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: 'logged out successfully'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  private

  def decode_jwt_token(token)
    JsonWebToken.decode(token)
  end
end
