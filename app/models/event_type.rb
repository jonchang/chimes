class EventType < ActiveRecord::Base
  belongs_to :conference
  has_many :events, dependent: :destroy

  validates :name, presence: true
  validates :length, presence: true, numericality: { only_integer: true }
  validates :warning_time, numericality: { only_integer: true, less_than: :length }, allow_nil: true
  validates :passing_time, numericality: { only_integer: true, less_than_or_equal_to: :length }, allow_nil: true

  def warning_time_used
    !self.warning_time.nil?
  end

  def passing_time_used
    !self.passing_time.nil?
  end

  def color
    ['darkmagenta', 'darkgrey', 'darkslateblue', 'darkred', 'darkgreen', 'darkblue', 'darkcyan', 'darkslategrey', 'darkgoldenrod'][id % 9]
  end

end
