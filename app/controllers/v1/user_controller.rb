class V1::UserController < ApplicationController
  include UserHelper

  def index
    current_user = checkUser(request)
    unless current_user.nil?
      if !params['user']['email'].nil?
        @user = User.where(email: params['user']['email']).first
      elsif !params['user']['name'].nil?
        @user = User.where(name: params['user']['name']).first
      else
        @user = nil
      end
      if @user.nil?
        render json: {
          error: { code: 400, message: "Not found user." }
        }, status: 400
      end
    else
      # render json: { errors: 'Not Found' }
      render json: {
        error: { code: 401, message: "Unauthorized auth_token." }
      }, status: 401
    end
  end

end
