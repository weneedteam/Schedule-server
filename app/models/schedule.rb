class Schedule < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :schedule_users

  validates :title, :start_time, :latitude, :longitude,
            :state, :event_id, presence: true

  def self.between(year)
    where('start_time BETWEEN ? AND ?', "#{year}-01-01 00:00:00", "#{year}-12-31 12:59:59")
  end

end
