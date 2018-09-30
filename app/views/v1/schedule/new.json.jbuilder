json.extract! @schedule, :id, :title, :start_time.strftime('%Y-%m-%d %H:%M:%S')
