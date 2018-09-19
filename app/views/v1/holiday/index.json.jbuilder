json.array!(@holidays) do |holiday|
  json.extract! holiday, :id, :name, :year, :month, :day
  json.created_at holiday.created_at.to_i
  json.updated_at holiday.updated_at.to_i
end