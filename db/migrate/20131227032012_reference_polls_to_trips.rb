class ReferencePollsToTrips < ActiveRecord::Migration
  def change
  	add_column :polls, :trip_id, :integer
  end
end
