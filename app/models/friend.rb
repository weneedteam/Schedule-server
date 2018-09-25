class Friend < ActiveRecord::Base

    private
    def self.get_friends(user_id)
        where('request_user_id = ? or response_user_id = ?', user_id, user_id).where(assent: true)
    end
end
