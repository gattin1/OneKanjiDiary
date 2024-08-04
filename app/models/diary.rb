# frozen_string_literal: true

# Diaryモデルは、ユーザーの日記データを管理します。
# 日記の内容、メモ、日付などの属性を持ちます。
class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :mood

  validates :title, presence: true, length: { is: 1 }
  validates :memo, length: { maximum: 255 }
  validates :date, presence: true, uniqueness: { scope: :user_id }
end
