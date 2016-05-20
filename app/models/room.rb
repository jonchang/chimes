class Room < ActiveRecord::Base

  belongs_to :conference
  has_many :events, :dependent => :destroy

  validates :name, presence: true

  amoeba do
    enable
    append :name => ' copy'
  end

end
