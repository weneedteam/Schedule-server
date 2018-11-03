json.array!(@schedules) do |schedule|
  json.id schedule.id
  json.state schedule.state
  json.title schedule.title
  json.start_time schedule.start_time.strftime('%Y-%m-%d %H:%M:%S')
  json.latitude schedule.latitude
  json.longitude schedule.longitude
  json.assent schedule.assent
  json.user (ScheduleUser.where(schedule_id: schedule.id)) do |schedule_user|
    unless schedule_user.user.nil?
      json.id schedule_user.user.id
      json.name schedule_user.user.name
      json.email schedule_user.user.email
      json.arrive schedule_user.arrive
      json.schedule_user_id schedule_user.id
    end
  end
end
