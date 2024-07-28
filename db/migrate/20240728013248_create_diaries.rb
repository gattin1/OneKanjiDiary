class CreateDiaries < ActiveRecord::Migration[7.1]
  def change
    create_table :diaries do |t|
      t.integer :user_id
      t.string :content
      t.string :memo
      t.date :date

      t.timestamps
    end
  end
end
