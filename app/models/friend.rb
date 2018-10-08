class Friend < ActiveRecord::Base

  def self.get_friends(user_id)
    where('request_user_id = ? or response_user_id = ?', user_id, user_id).where(assent: true)
  end

  def self.check_friend(my_id, user_id)
    where('(request_user_id = ? and response_user_id = ?) or (request_user_id = ? and response_user_id = ?)', my_id, user_id, user_id, my_id)
  end

end
