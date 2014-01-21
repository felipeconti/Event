class AlterReferenceTablesToEvents < ActiveRecord::Migration
  def change
    rename_column :comments, :trip_id, :event_id
    rename_column :polls, :trip_id, :event_id
    rename_column :items, :trip_id, :event_id
  end
end
