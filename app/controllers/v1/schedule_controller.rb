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
          code: 401, message: [ "Unauthorized auth_token." ]
      }, status: 401
    end
  end

  def new
    current_user = checkUser(request)
    unless current_user.nil?
      @schedule = Schedule.new schedule_params.merge(user_id: current_user.id)
      @schedule.save
    else
      render json: {
          code: 401, message: [ "Unauthorized auth_token." ]
      }, status: 401
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
