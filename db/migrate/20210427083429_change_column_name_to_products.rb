class ChangeColumnNameToProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :zpicode, :zipcode
  end
end
