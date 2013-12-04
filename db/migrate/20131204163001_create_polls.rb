class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :description
      t.text :complement

      t.timestamps
    end
  end
end
