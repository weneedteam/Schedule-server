class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :schedule

  validates :title, :color, :user_id, presence: true

end
