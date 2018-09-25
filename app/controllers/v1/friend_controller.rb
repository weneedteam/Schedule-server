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
        message: { code: 401, message: "Unauthorized auth_token." }
      }, status: 401
    end
  end

  def new
  end
end
