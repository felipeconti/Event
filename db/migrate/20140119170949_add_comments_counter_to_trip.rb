class AddCommentsCounterToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :comments_count, :integer, null: false, default: 0
  end
end
