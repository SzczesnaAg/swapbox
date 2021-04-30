class RenameRefToOtherProductIdToSwaps < ActiveRecord::Migration[6.0]
  def change
    rename_column :swaps, :other_product_id_id, :other_product_id
  end
end
