class Schedule < ActiveRecord::Base
  belongs_to :user

  validates :title, :start_time
end
