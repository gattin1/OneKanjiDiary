# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Diaries",  js: true, type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:rack_test) # テストのドライバを指定 (ブラウザなしで実行)
    sign_in user # Deviseのヘルパーを使ってユーザーをサインイン
  end

  it '日記を作成できること' do
    visit new_user_diary_path(user)

    fill_in '今日の一文字', with: 'A'
    fill_in 'メモ', with: 'This is a test diary entry.'
    fill_in '日付', with: Date.today

    click_button '日記を作成する'

    expect(page).to have_content('日記が作成されました')
    expect(page).to have_content('A')
  end

  it '日記を一覧表示できること' do
    create(:diary, user: user, title: 'A')
    create(:diary_with_different_title, user: user, title: 'B')

    visit user_diaries_path(user)

    expect(page).to have_content('A')
    expect(page).to have_content('B')
  end

  it '日記を編集できること' do
    diary = create(:diary, user: user) # テスト用の日記を作成

    visit edit_user_diary_path(user, diary) # 編集ページに移動

    fill_in '今日の一文字', with: 'B' # Contentを新しい内容に変更
    fill_in 'メモ', with: 'Updated test diary entry.' # Memoを新しい内容に変更
    click_button '日記を更新する' # 更新ボタンをクリック

    expect(page).to have_content('日記が更新されました。') # 更新成功のメッセージを確認
    expect(page).to have_content('B') # 更新された日記の内容が表示されていることを確認
  end

  it '日記を削除できること' do
    diary = create(:diary, user: user) # テスト用の日記を作成

    visit user_diary_path(user, diary) # 日記の詳細ページに移動

    accept_confirm do
      click_link '削除する' # 削除ボタンをクリック
    end

    expect(page).to have_content('日記が削除されました。') # 削除成功のメッセージを確認
    expect(page).not_to have_content(diary.title) # 削除された日記の内容が表示されていないことを確認
  end
end
