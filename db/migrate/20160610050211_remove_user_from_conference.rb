class RemoveUserFromConference < ActiveRecord::Migration
  def change
    remove_reference :conferences, :user, index: true, foreign_key: true
  end
end
