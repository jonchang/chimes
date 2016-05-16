class Conference < ActiveRecord::Base

  belongs_to :user
  has_many :event_types
  has_many :rooms

  validates :name, presence: true

  def get_time_zone
    ActiveSupport::TimeZone.new(self.time_zone)
  end

end
