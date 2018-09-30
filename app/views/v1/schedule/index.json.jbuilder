json.array!(@schedules) do |schedule|
  json.id    schedule.id
  json.title  schedule.title
  json.start_time schedule.start_time.strftime('%Y-%m-%d %H:%M:%S')
end