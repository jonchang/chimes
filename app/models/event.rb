class Event < ActiveRecord::Base
  has_one :event_type
  belongs_to :room

  amoeba do
    enable
  end

  def json_data
    {
      id: "event[#{id}]",
      title: event_type.name,
      allDay: false,
      start: datetime.iso8601,
      end: datetime.advance(minutes: length).iso8601,
      color: 'aliceblue'
    }
  end

end
