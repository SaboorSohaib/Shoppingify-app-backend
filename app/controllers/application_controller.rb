require 'English'
require "#{Rails.root}/lib/json_web_token"

class ApplicationController < ActionController::API
    before_action :authenticate_user_if_token_present
    before_action :update_allowed_parameters, if: :devise_controller?

    private

    def update_allowed_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    end

    def authenticate_user_if_token_present
      token = request.headers['Authorization']&.split(' ')&.last
      return unless token
  
      payload = JsonWebToken.decode(token)
      user_id = payload['sub']
      @current_user = User.find_by(id: user_id)
      render json: { error: 'Invalid or expired token' }, status: :unauthorized if @current_user.nil?
    rescue JWT::ExpiredSignature, JWT::DecodeError
      render json: { error: 'Invalid or expired token' }, status: :unauthorized
    end

    def authenticate_request
        unless user_id_in_token?
          render json: { error: 'Not Authorized' }, status: :unauthorized
          return
        end
        token = request.headers['Authorization']&.split(' ')&.last
        payload = JsonWebToken.decode(token)
        user_id = payload['sub']
        @current_user = User.find_by(id: user_id)
      rescue JWT::VerificationError, JWT::DecodeError
        render json: { error: 'Not Authorized' }, status: :unauthorized
    end
    
    def http_token
        @http_token ||= (request.headers['Authorization'].split.last if request.headers['Authorization'].present?)
    end
    
    def auth_token
        @auth_token ||= JsonWebToken.decode(http_token)
    end
    
    def user_id_in_token?
        http_token && auth_token && auth_token[:user_id].to_i
    end
end
