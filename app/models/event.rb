class Event < ActiveRecord::Base
  belongs_to :event_type
  belongs_to :room

  before_save :round_datetime

  amoeba do
    enable
  end

  def json_data
    {
      id: id,
      title: event_type.name,
      allDay: false,
      start: datetime.iso8601,
      end: datetime.advance(minutes: event_type.length).iso8601,
      color: event_type.color
    }
  end

  def round_datetime
    self.datetime = datetime&.+(30.seconds)&.beginning_of_minute
  end

  def start_time
    room.conference.get_time_zone.parse(datetime.asctime)
  end

  def warning_time
    room.conference.get_time_zone.parse(datetime.asctime).advance(minutes: event_type.warning_time) unless event_type.warning_time.nil?
  end

  def passing_time
    room.conference.get_time_zone.parse(datetime.asctime).advance(minutes: event_type.passing_time) unless event_type.passing_time.nil?
  end

  def chime_js(now)
    js = ''
    puts 'now'
    puts now
    puts 'start'
    puts start_time
    js += delayed_js('start-chime', start_time - now) if start_time - now >= 0
    js += delayed_js('warning-chime', warning_time - now) if warning_time and warning_time - now >= 0
    js += delayed_js('passing-chime', passing_time - now) if passing_time and passing_time - now >= 0
    js
  end

  def delayed_js(id, delay)
    "setTimeout(function() { $('##{id}').prop('currentTime', 0); $('##{id}').trigger('play')}, #{delay.in_milliseconds});\n"
  end

end
