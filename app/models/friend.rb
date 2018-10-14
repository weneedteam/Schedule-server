class Friend < ActiveRecord::Base

  def self.get_friends(user_id)
    select("users.*, friends.assent, (friends.request_user_id = #{user_id}) as request")
        .joins("join users on users.id = IF (friends.request_user_id = #{user_id}, friends.response_user_id, friends.request_user_id)")
        .where('friends.request_user_id = ? or friends.response_user_id = ?', user_id, user_id)

    # select users.*, friends.assent, (friends.request_user_id = 1) as request
    # from friends
    # join users on users.id = if (friends.request_user_id = 1, friends.response_user_id, friends.request_user_id)
    # where friends.request_user_id = 1 or friends.response_user_id = 1;
  end

  def self.check_friend(my_id, user_id)
    where('(request_user_id = ? and response_user_id = ?) or (request_user_id = ? and response_user_id = ?)', my_id, user_id, user_id, my_id)
  end

  def self.request_user(friend_id)
    select('users.*, friends.id as friend_id').joins('join users on friends.request_user_id = users.id').where(id: friend_id).first
  end

  def self.response_user(friend_id)
    select('users.*, friends.id as friend_id').joins('join users on friends.response_user_id = users.id').where(id: friend_id).first
  end

  def get_response_user(user_id)
    User.find user_id
  end

end
