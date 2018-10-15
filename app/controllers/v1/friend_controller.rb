class V1::FriendController < ApplicationController
  include UserHelper
  include PushHelper

  def index
    current_user = checkUser(request)
    if current_user.nil?
      @message = ['Unauthorized auth_token.']
      render 'error/error', status: 401
    else
      @friends = Friend.get_friends(current_user.id)
    end
  end

  def new
    current_user = checkUser(request)
    if current_user.nil?
      @message = ['Unauthorized auth_token.']
      render 'error/error', status: 401
    else
      user_ids = params[:_json]
      if user_ids.nil?
        @message = ['No have users id']
        render 'error/error', status: 400
      else

        @friends = Array.new
        user_ids.each do |user_id|
          user = User.find(user_id)
          check = Friend.check_friend(current_user.id, user_id).first

          friend = {}
          friend[:id] = user.id
          friend[:name] = user.name
          friend[:email] = user.email
          friend[:birth] = user.birth

          if check.nil?
            new_friend = Friend.new
            new_friend.request_user_id = current_user.id
            new_friend.response_user_id = user_id
            new_friend.assent = 1
            new_friend.save

            friend[:assent] = 1

            data = {
              type: 'friend',
              user: {
                name: current_user.name,
                email: current_user.email,
                birth: current_user.birth.to_i,
                friend_id: new_friend.id
              }
            }
            push(user.fcm_token, data)
          else
            friend[:assent] = check.assent
          end

          @friends.push(friend)
        end
        render json: @friends.to_json, status: 200
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
      @friend = Friend.where(id: params[:id]).first
      request_user = Friend.request_user(@friend.id)
      response_user = Friend.response_user(@friend.id)

      if @friend.blank? && @friend.response_user_id != current_user.id
        render json: {
          code: 404, message: ['Not Found Friend.']
        }, status: 404
      else
        answer = params[:answer]
        if answer
          @friend.assent = 2
          @friend.assented_at = params[:answered_at]
          @friend.save
        else
          @friend.destroy
        end

        data = {
          type: 'friend',
          friend: {
            user_id: response_user.id,
            is_friend: answer ? 2 : 0,
            is_friend_at: params[:answered_at],
            user_name: response_user.name
          }
        }
        push(request_user.fcm_token, data)

        render json: {
          code: 200, message: ['Complete!']
        }, status: 200
      end
    end
  end
end
