class RemoveOwnerOfHolders < ActiveRecord::Migration
  def change
  	remove_column :holders, :owner
  end
end
