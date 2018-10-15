json.array!(@friends) do |friend|
  json.id friend.id
  json.name friend.name
  json.email friend.email
  json.birth friend.birth.to_i
  json.request friend.request == 1
  json.assent friend.assent
  json.friend_id friend.friend_id
end