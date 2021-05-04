class AddNotifyRequesterToSwaps < ActiveRecord::Migration[6.0]
  def change
    add_column :swaps, :notify_requester, :boolean, default: false
  end
end
