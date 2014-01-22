class CreateTableRelationBetweenUserAndEvent < ActiveRecord::Migration
  def change
    create_table :events_users, :id => false do |t|
      t.belongs_to :event
      t.belongs_to :user
    end
    add_index :events_users, [:event_id, :user_id]
  end
end
