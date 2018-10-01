class Schedule < ActiveRecord::Base
  belongs_to :user
  has_many :schedule_user

  validates :title, :start_time, :latitude, :longitude, presence: true

  def self.between(year)
    where('start_time BETWEEN ? AND ?', "#{year}-01-01 00:00:00", "#{year}-12-31 12:59:59")
  end

end
