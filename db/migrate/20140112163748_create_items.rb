class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :amount
      t.float :value
      t.integer :trip_id

      t.timestamps
    end
  end
end
