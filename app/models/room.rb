class Room < ActiveRecord::Base

  belongs_to :conference
  has_many :events

  validates :name, presence: true

end
