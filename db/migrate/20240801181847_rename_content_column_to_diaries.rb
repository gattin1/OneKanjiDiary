class RenameContentColumnToDiaries < ActiveRecord::Migration[7.1]
  def change
    rename_column :diaries, :content, :title
  end
end
