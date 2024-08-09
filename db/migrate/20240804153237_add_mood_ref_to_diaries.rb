class AddMoodRefToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_reference :diaries, :mood, null: false, foreign_key: true

    # 必要であればデフォルト値を設定（任意）
    change_column_default :diaries, :mood_id, 6
  end
end
