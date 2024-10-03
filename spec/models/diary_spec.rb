# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Diary, type: :model do
  subject(:diary) do
    described_class.new(
      title: 'A',
      memo: 'This is a test memo.',
      date: Time.zone.today,
      user: user,
      mood: mood
    )
  end

  let(:user) { create(:user) }
  let(:mood) { create(:mood) }

  describe 'バリデーション' do
    it '有効な属性であれば有効であること' do
      expect(diary).to be_valid
    end

    context 'titleのバリデーション' do
      it 'titleがなければ無効であること' do
        diary.title = nil
        expect(diary).not_to be_valid
      end

      it 'titleがなければエラーメッセージが表示されること' do
        diary.title = nil
        diary.validate
        expect(diary.errors[:title]).to include("を入力してください")
      end

      it 'titleの長さが1文字でなければ無効であること' do
        diary.title = 'AB'
        expect(diary).not_to be_valid
      end

      it 'titleの長さが1文字でなければエラーメッセージが表示されること' do
        diary.title = 'AB'
        diary.validate
        expect(diary.errors[:title]).to include('は一文字で入力してください')
      end
    end

    context 'dateのバリデーション' do
      it 'dateがなければ無効であること' do
        diary.date = nil
        expect(diary).not_to be_valid
      end

      it 'dateがなければエラーメッセージが表示されること' do
        diary.date = nil
        diary.validate
        expect(diary.errors[:date]).to include("を入力してください")
      end
    end

    context '同じユーザーに対して日付が一意でなければ無効であること' do
      it '日付が一意でなければ無効であること' do
        create(:diary, date: Time.zone.today, user: user, mood: mood)
        expect(diary).not_to be_valid
      end

      it '日付が一意でなければエラーメッセージが表示されること' do
        create(:diary, date: Time.zone.today, user: user, mood: mood)
        diary.validate
        expect(diary.errors[:date]).to include('は既に存在します')
      end
    end

    context 'メモのバリデーション' do
      it 'メモが最大255文字であれば有効であること' do
        diary.memo = 'a' * 255
        expect(diary).to be_valid
      end

      it 'メモが255文字を超える場合は無効であること' do
        diary.memo = 'a' * 256
        expect(diary).not_to be_valid
      end

      it 'メモが255文字を超える場合はエラーメッセージが表示されること' do
        diary.memo = 'a' * 256
        diary.validate
        expect(diary.errors[:memo]).to include('は255文字以内で入力してください')
      end
    end

    context 'moodのバリデーション' do
      it 'moodがなければ無効であること' do
        diary.mood = nil
        expect(diary).not_to be_valid
      end

      it 'moodがなければエラーメッセージが表示されること' do
        diary.mood = nil
        diary.validate
        expect(diary.errors[:mood]).to include("を入力してください")
      end
    end
  end

  describe 'アソシエーション' do
    it 'Userに属していること' do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end

    it 'Moodに属していること' do
      assoc = described_class.reflect_on_association(:mood)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
