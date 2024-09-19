class AddReminderTimeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :reminder_time, :time
  end
end
