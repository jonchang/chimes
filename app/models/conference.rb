class Conference < ActiveRecord::Base

  belongs_to :user
  has_many :event_types
  has_many :rooms

  validates :name, presence: true, uniqueness: { scope: :user }

  def get_time_zone
    ActiveSupport::TimeZone.new(time_zone)
  end

end
