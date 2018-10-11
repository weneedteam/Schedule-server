class V1::EventController < ApplicationController
  include UserHelper

  def index
    current_user = checkUser(request)
    if current_user.nil?
      render json: {
        code: 401, message: ['Unauthorized auth_token.']
      }, status: 401
    else
      @events = Event.where(user_id: params[:user_id])
    end
  end

  def new
    current_user = checkUser(request)
    if current_user.nil?
      render json: {
        code: 401, message: ['Unauthorized auth_token.']
      }, status: 401
    else
      @events = Event.where(user_id: params[:user_id])
    end
  end

  private

  def schedule_params
    params.require(:event).permit!
  end

end
