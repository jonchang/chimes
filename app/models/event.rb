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
    self.datetime = datetime&.beginning_of_minute
  end

end
