class EventType < ActiveRecord::Base
  belongs_to :conference

  def warning_time_used
    !self.warning_time.nil?
  end

  def passing_time_used
    !self.passing_time.nil?
  end

end
