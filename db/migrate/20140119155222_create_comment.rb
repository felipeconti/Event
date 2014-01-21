class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :trip_id
      t.integer :user_id
      t.string :title
      t.text :message

      t.timestamps
    end
    add_index :comments, :trip_id
    add_index :comments, :user_id
  end
end