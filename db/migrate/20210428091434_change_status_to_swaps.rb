class ChangeStatusToSwaps < ActiveRecord::Migration[6.0]
  def change
    remove_column :swaps, :status
  end
end
