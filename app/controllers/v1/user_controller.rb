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
          message: { code: 404, message: "Not found user." }
        }, status: 404
      end
    else
      render json: {
        message: { code: 401, message: "Unauthorized auth_token." }
      }, status: 401
    end
  end

  def fcm_token
    current_user = checkUser(request)
    unless current_user.nil?
      fcm_token = params['user']['fcm_token']
      if !fcm_token.nil?
        current_user.fcm_token = fcm_token
        current_user.save
        render json: {
          message: { code: 200, message: "Complete!" }
        }, status: 200
      else
        render json: {
          message: { code: 400, message: "fcm token is null." }
        }, status: 400
      end
    else
      render json: {
        message: { code: 401, message: "Unauthorized auth_token." }
      }, status: 401
    end
  end

end
