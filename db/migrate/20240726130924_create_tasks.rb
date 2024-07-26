class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    drop_table :tasks, if_exists: true
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
enda
