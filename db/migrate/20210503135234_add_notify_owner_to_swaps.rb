class AddNotifyOwnerToSwaps < ActiveRecord::Migration[6.0]
  def change
    add_column :swaps, :notify_owner, :boolean, default: false
  end
end
