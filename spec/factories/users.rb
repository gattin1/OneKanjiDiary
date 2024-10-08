# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'name' }
    email { 'test@example.com' }
    password { 'password' }
  end
end
