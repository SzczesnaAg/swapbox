class AddStateToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :state, :string
  end
end
