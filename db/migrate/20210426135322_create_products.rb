class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :type
      t.text :description
      t.string :categories
      t.string :street
      t.integer :zpicode
      t.string :city
      t.integer :status

      t.timestamps
    end
  end
end
