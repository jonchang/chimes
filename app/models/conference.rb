class Conference < ActiveRecord::Base

  has_many :managers
  has_many :users, through: :managers
  has_many :event_types
  has_many :rooms

  validates :name, presence: true

  def get_time_zone
    ActiveSupport::TimeZone.new(time_zone)
  end

  def permitted?(user)
    users.include? user
  end

end
