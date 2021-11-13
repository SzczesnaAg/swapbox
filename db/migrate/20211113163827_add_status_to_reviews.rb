class AddStatusToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :status, :integer, default: 0 , null: false
  end
end
