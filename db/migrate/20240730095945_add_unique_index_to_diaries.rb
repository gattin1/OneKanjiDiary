# frozen_string_literal: true

class AddUniqueIndexToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_index :diaries, %i[user_id date], unique: true
  end
end
