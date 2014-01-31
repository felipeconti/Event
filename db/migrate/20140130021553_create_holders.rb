class CreateHolders < ActiveRecord::Migration
  def change
    create_table :holders do |t|
   	  t.belongs_to :user
      t.belongs_to :event
      t.boolean :edit, default: false
      t.boolean :owner, default: false

      t.timestamps
    end
    add_index :holders, [:event_id, :user_id]
  end
end
