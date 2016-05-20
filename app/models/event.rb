class Event < ActiveRecord::Base
  has_one :event_type
  belongs_to :room

  amoeba do
    enable
  end

end
