class AddNotificationMessageToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :notify_message_owner, :boolean, default: false
    add_column :messages, :notify_message_receiver, :boolean, default: false
  end
end
