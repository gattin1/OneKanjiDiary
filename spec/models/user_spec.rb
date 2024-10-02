# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'バリデーション' do
    it '有効な属性であれば有効であること' do
      user = described_class.new(email: 'test@example.com', password: 'password', password_confirmation: 'password',
                                 name: 'Test User')
      expect(user).to be_valid
    end

    it 'メールアドレスが無ければ無効であること' do
      user = described_class.new(email: nil, password: 'password', name: 'Test User')
      expect(user).not_to be_valid
    end

    it 'パスワードが無ければ無効であること' do
      user = described_class.new(email: 'test@example.com', password: nil, name: 'Test User')
      expect(user).not_to be_valid
    end

    it '重複したメールアドレスは無効であること' do
      described_class.create(email: 'test@example.com', password: 'password', name: 'Test User')
      user = described_class.new(email: 'test@example.com', password: 'password', name: 'Test User 2')
      expect(user).not_to be_valid
    end

    it 'パスワード確認が一致しない場合は無効であること' do
      user = described_class.new(email: 'test@example.com', password: 'password',
                                 password_confirmation: 'different_password', name: 'Test User')
      expect(user).not_to be_valid
    end
  end
end
