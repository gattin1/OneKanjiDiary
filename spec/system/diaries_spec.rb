# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Diaries', type: :system do
  let!(:user) { create(:user) }
  let!(:mood) { create(:mood) }

  before do
    driven_by(:rack_test) # テストのドライバを指定 (ブラウザなしで実行)
    create(:mood)
    sign_in user # Deviseのヘルパーを使ってユーザーをサインイン
  end

  describe '日記の作成' do
    it '日記作成フォームを表示できること' do
      visit new_user_diary_path(user)
      expect(page).to have_content('今日の一文字')
    end

    it '日記を作成できること' do
      visit new_user_diary_path(user)

      fill_in '今日の一文字', with: '人'
      fill_in 'メモ (書かなくても可)', with: 'これは日記です。'
      fill_in '日付', with: Time.zone.today

      choose "mood_#{Mood.first.id}"

      click_button '日記を作成する'

      expect(page).to have_content('日記が作成されました')
    end

    it '作成された日記が表示されること' do
      create(:diary, user: user, title: '人')
      visit user_diaries_path(user)
      expect(page).to have_content('人')
    end
  end

  describe '日記の一覧表示' do
    it '日記Aを表示できること' do
      create(:diary, user: user, title: 'A')
      visit user_diaries_path(user)
      expect(page).to have_content('A')
    end

    it '日記Bを表示できること' do
      create(:diary_with_different_title, user: user, title: 'B')
      visit user_diaries_path(user)
      expect(page).to have_content('B')
    end
  end

  describe '日記の編集' do
    it '編集フォームを表示できること' do
      diary = create(:diary, user: user)
      visit edit_user_diary_path(user, diary)
      expect(page).to have_content('今日の一文字')
    end

    it '日記を編集できること' do
      diary = create(:diary, user: user)

      visit edit_user_diary_path(user, diary)

      fill_in '今日の一文字', with: 'B'
      fill_in 'メモ', with: 'Updated test diary entry.'
      click_button '日記を更新する'

      expect(page).to have_content('日記が更新されました。')
    end

    it '編集された内容が表示されること' do
      diary = create(:diary, user: user, title: 'B', memo: 'Updated test diary entry.')
      visit user_diary_path(user, diary)
      expect(page).to have_content('B')
      expect(page).to have_content('Updated test diary entry.')
    end
  end

  describe '日記の削除' do
    it '日記を削除できること' do
      diary = create(:diary, user: user)

      visit user_diary_path(user, diary) # 日記の詳細ページに移動

      # JavaScriptを使わずに直接削除リクエストを送信
      page.driver.submit :delete, user_diary_path(user, diary), {}

      expect(page).to have_content('日記が削除されました。')
    end

    it '削除された日記が表示されないこと' do
      diary = create(:diary, user: user, title: '削除された日記')

      visit user_diaries_path(user)
      expect(page).not_to have_content(diary.title)
    end
  end
end
