class RemoveStatusToReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :status, :integer, default: 0 , null: false
  end
end
