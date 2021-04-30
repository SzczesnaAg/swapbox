class RemoveOtherProductIdIntegerFromSwaps < ActiveRecord::Migration[6.0]
  def change
    remove_column :swaps, :other_product_id, :integer
  end
end
