json.extract! @schedule, :id, :title, :state
json.start_time @schedule.start_time.strftime('%Y-%m-%d %H:%M:%S')
json.latitude @schedule.latitude
json.longitude @schedule.longitude
json.user (@schedule_users) do |schedule_user|
  unless schedule_user.user.nil?
    json.id schedule_user.user.id
    json.name schedule_user.user.name
    json.email schedule_user.user.email
    json.arrive schedule_user.arrive
    json.arrived_at schedule_user.arrived_at.strftime('%Y-%m-%d %H:%M:%S') unless schedule_user.arrived_at.nil?
  end
end