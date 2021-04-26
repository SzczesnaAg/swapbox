class RenameCategoriesInProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :categories, :tags
  end
end
