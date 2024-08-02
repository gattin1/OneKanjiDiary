# frozen_string_literal: true

FactoryBot.define do
  factory :diary do
    title { 'A' } # titleを1文字で設定
    memo { 'This is a test memo.' } # 任意でメモを設定
    date { Date.today } # 今日の日付をデフォルトで設定
    association :user # 関連するユーザーを設定
  end

  factory :diary_with_different_title, class: 'Diary' do
    title { 'B' } # titleを1文字で設定
    memo { 'This is a test memo_2.' } # 任意でメモを設定
    date { Date.tomorrow } # 今日の日付をデフォルトで設定
    association :user # 関連するユーザーを設定
  end
end
