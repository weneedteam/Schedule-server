require 'date'
class V1::ScheduleController < ApplicationController
  include UserHelper

  def index
    current_user = checkUser(request)
    unless current_user.nil?
      year = params[:year].to_i
      @schedules = Schedule.between(year).where(user_id: current_user.id)
    else
      render json: {
          code: 401, message: ["Unauthorized auth_token."]
      }, status: 401
    end
  end

  def new
    current_user = checkUser(request)
    unless current_user.nil?
      @schedule = Schedule.new schedule_params.merge(user_id: current_user.id)
      @schedule.save

      user_ids = params['user_ids'].nil? ? Array.new : params['user_ids']
      if !user_ids.include? current_user.id
        user_ids.push(current_user.id)
      end

      @schedule_users = Array.new
      user_ids.each do |user_id|
        schedule_user = ScheduleUser.new
        schedule_user.schedule_id = @schedule.id
        schedule_user.user_id = user_id
        schedule_user.arrive = (user_id == current_user.id)
        schedule_user.save

        if !check_user = User.where(id: user_id).blank?
          @schedule_users.push(User.where(id: user_id).first)
        end
      end

    else
      render json: {
        code: 401, message: ['Unauthorized auth_token.']
      }, status: 401
    end
  end

  def show
    if request.headers['Accept'] != 'application/json'
      render json: {
        code: 406, message: ['Not Acceptable, not supports.']
      }, status: 406
    else
      @schedule = Schedule.find(params[:id])
    end
  end

  private

  def schedule_params
    schedule = params.require(:schedule).permit!
    # date = DateTime.parse(params[:start_time])
    # schedule[:start_time] = date.strftime('%a %b %d %H:%M:%S %Z %Y')
    schedule
  end
end
