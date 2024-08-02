# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Diary, js: true, type: :model do
  let(:user) { create(:user) }

  # テスト対象のDiaryモデルのインスタンスを作成
  subject {
    described_class.new(
      title: 'A', # 日記の内容を1文字に設定
      memo: "This is a test memo.", # メモを設定
      date: Date.today, # 今日の日付を設定
      user: user # 先に作成したユーザーを関連付け
    )
  }

  describe 'バリデーション' do
    it '有効な属性であれば有効であること' do
      expect(subject).to be_valid
    end

    it 'titleがなければ無効であること' do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it 'titleの長さが1文字でなければ無効であること' do
      subject.title = 'AB'
      expect(subject).not_to be_valid
    end

    it 'dateがなければ無効であること' do
      subject.date = nil
      expect(subject).not_to be_valid
    end

    it '同じユーザーに対して日付が一意でなければ無効であること' do
      create(:diary, date: Date.today, user: user)
      expect(subject).not_to be_valid
    end

    it 'メモが最大255文字であれば有効であること' do
      subject.memo = 'a' * 255
      expect(subject).to be_valid
    end

    it 'メモが255文字を超える場合は無効であること' do
      subject.memo = "a" * 256
      expect(subject).not_to be_valid
    end
  end

  describe "アソシエーション" do
    # DiaryモデルがUserに属していることを確認
    it "Userに属していること" do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
