class AddAnotherProductIdToSwaps < ActiveRecord::Migration[6.0]
  def change
    add_column :swaps, :other_product_id, :integer
    add_reference :swaps, :other_product_id, foreign_key: { to_table: :products }
  end
end
