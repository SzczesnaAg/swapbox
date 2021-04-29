class AddStatusIntegerToSwaps < ActiveRecord::Migration[6.0]
  def change
    add_column :swaps, :status, :integer, default: 0 , null: false
  end
end
