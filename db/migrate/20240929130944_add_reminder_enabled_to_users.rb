class AddReminderEnabledToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :reminder_enabled, :boolean, default: false
  end
end
