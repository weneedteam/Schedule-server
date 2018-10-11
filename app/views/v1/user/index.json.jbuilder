json.extract! @user, :id, :name, :email
json.birth @user.birth.to_i
json.is_friend @friend.nil? ? 0 : @friend.assent