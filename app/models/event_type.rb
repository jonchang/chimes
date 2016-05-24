class EventType < ActiveRecord::Base
  belongs_to :conference

  validates :name, presence: true
  validates :length, presence: true

  def warning_time_used
    !self.warning_time.nil?
  end

  def passing_time_used
    !self.passing_time.nil?
  end

  def color
    ['darkblue', 'darkcyan', 'darkgoldenrod', 'darkgrey', 'darkgreen', 'darkmagenta', 'darkred', 'darkslateblue', 'darkslategrey'][id]
  end

end
