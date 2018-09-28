class V1::FriendController < ApplicationController
  include UserHelper

  def index
    current_user = checkUser(request)
    unless current_user.nil?
      @friends = Array.new
      Friend.get_friends(current_user.id).each do |friend|
        find_id = friend.request_user_id != current_user.id ? friend.request_user_id : friend.response_user_id
        @friends.push(User.find(find_id))
      end
    else
      render json: {
        result: { code: 401, message: "Unauthorized auth_token." }
      }, status: 401
    end
  end

  def new
    current_user = checkUser(request)
    unless current_user.nil?
      user_ids = params['user_ids']
      if !user_ids.nil?
        @friends = Array.new
        user_ids.each do |user_id|
          check = Friend.check_friend(current_user.id, user_id).first
          if check.nil?
            friend = Friend.new
            friend.request_user_id = current_user.id
            friend.response_user_id = user_id
            friend.assent = false
            friend.save

            @friends.push(User.find(user_id))
          end
        end
      else
        render json: {
          result: { code: 400, message: "No have users id" }
        }, status: 400
      end
    else
      render json: {
        result: { code: 401, message: "Unauthorized auth_token." }
      }, status: 401
    end
  end
end
