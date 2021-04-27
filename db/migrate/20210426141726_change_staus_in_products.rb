class ChangeStausInProducts < ActiveRecord::Migration[6.0]
  def change
     change_column :products, :status, :integer, default: 0 , null: false
  end
end
