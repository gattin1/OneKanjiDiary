# frozen_string_literal: true

# Diaryモデルは、ユーザーの日記データを管理する。
class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :mood

  # 指定された月の感情ごとの日記数を％で返すメソッド
  def self.mood_statistics_for_month(start_date)
    total_diaries = where(date: start_date.beginning_of_month..start_date.end_of_month).count
    return {} if total_diaries.zero?

    mood_data = joins(:mood)
                .where(date: start_date.beginning_of_month..start_date.end_of_month)
                .group('moods.name')
                .count

    # ％に変換
    mood_data.transform_values { |count| (count.to_f / total_diaries * 100).round }
  end

  validates :title, presence: true, length: { is: 1 }
  validates :memo, length: { maximum: 255 }
  validates :date, presence: true, uniqueness: { scope: :user_id }
end
