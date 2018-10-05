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

        check_user = User.where(id: user_id)
        if !check_user.blank?
          @schedule_users.push(check_user.first)
          data = {
              type: 'schedule',
              user: {
                  name: current_user.name,
                  email: current_user.email,
                  birth: current_user.birth.to_i
              },
              schedule: {
                  id: @schedule.id,
                  title: @schedule.title,
                  start_time: @schedule.start_time.strftime('%Y-%m-%d %H:%M:%S'),
                  latitude: @schedule.latitude,
                  longitude: @schedule.longitude
              }
          }
          push(check_user.fcm_token, data)
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
      @schedule = Schedule.where(id: params[:id]).first
      if @schedule.blank?
        render json: {
          code: 404, message: ['Not found schedule.']
        }, status: 404
      end
    end
  end

  def update
    current_user = checkUser(request)
    if current_user.nil?
      render json: {
        code: 401, message: ['Unauthorized auth_token.']
      }, status: 401
    else
      @schedule = Schedule.where(id: params[:id]).first
      if !@schedule.blank?
        if @schedule.user_id == current_user.id
          @schedule.update(schedule_params)
          @schedule.save
          render 'v1/schedule/show'
        else
          render json: {
            code: 403, message: ['Do not update.']
          }, status: 403
        end
      else
        render json: {
          code: 404, message: ['Not found schedule.']
        }, status: 404
      end
    end
  end

  def delete
    current_user = checkUser(request)
    if current_user.nil?
      render json: {
        code: 401, message: ['Unauthorized auth_token.']
      }, status: 401
    else
      @schedule = Schedule.where(id: params[:id]).first
      if !@schedule.blank?
        if @schedule.user_id == current_user.id
          @schedule.schedule_user.destroy_all
          @schedule.destroy
          render json: {
            code: 200, message: ['Delete Complete!']
          }, status: 200
        else
          render json: {
            code: 403, message: ['Do not delete.']
          }, status: 403
        end
      else
        render json: {
          code: 404, message: ['Not found schedule.']
        }, status: 404
      end
    end
  end

  def arrive
    current_user = checkUser(request)
    if current_user.nil?
      render json: {
        code: 401, message: ['Unauthorized auth_token.']
      }, status: 401
    else
      @schedule = Schedule.where(id: params[:id]).first
      if !@schedule.blank?
        @schedule.schedule_users.each do |schedule_user|
          if schedule_user.user_id == current_user.id
            schedule_user.arrived_at = params[:arrived_at]
            schedule_user.save
          end
        end
        render json: {
          code: 200, message: ['Complete!']
        }, status: 200
      else
        render json: {
          code: 404, message: ['Not found schedule.']
        }, status: 404
      end
    end
  end

  def consent
    current_user = checkUser(request)
    if current_user.nil?
      render json: {
        code: 401, message: ['Unauthorized auth_token.']
      }, status: 401
    else
      @schedule = ScheduleUser.where(id: params[:id]).first
      if @schedule.blank? || @schedule.user_id != current_user.id
        render json: {
          code: 404, message: ['Not Found Schedule.']
        }, status: 404
      else
        @schedule.arrive = params[:answer]
        @schedule.save

        render json: {
            code: 200, message: ['Complete!']
        }, status: 200
      end
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
