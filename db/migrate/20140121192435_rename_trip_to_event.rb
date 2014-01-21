class RenameTripToEvent < ActiveRecord::Migration
  def change
    rename_table :trips, :events
  end
end
