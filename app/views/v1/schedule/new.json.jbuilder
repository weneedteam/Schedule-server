json.extract! @schedule, :id, :title
json.start_time @schedule.start_time.strftime('%Y-%m-%d %H:%M:%S')
json.latitude @schedule.latitude
json.longitude @schedule.longitude
json.user (@schedule_users) do |user|
  json.id user.id
  json.name user.name
  json.email user.email
end