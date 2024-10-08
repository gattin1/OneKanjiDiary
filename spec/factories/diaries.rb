# frozen_string_literal: true

FactoryBot.define do
  factory :mood do
    name { '幸せ' }
    color { 'yellow' }
  end
  factory :diary do
    title { '子' }
    memo { 'This is a test memo.' }
    date { Time.zone.today }
    association :user
    association :mood
  end

  factory :diary_with_different_title, class: 'Diary' do
    title { '児' }
    memo { 'This is a test memo_2.' }
    date { Date.tomorrow }
    association :user
    association :mood
  end
end
