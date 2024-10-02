# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  before do
    driven_by(:rack_test) # 非JavaScriptテスト用のドライバー。必要に応じて変更可能。
  end

  context '新しいユーザーの作成' do
    before do
      visit new_user_registration_path
      fill_in 'メールアドレス', with: user_email
      fill_in 'パスワード', with: user_password
      fill_in 'パスワード（確認用）', with: password_confirmation
      fill_in 'ニックネーム', with: user_name
      click_button 'アカウント登録'
    end

    context '有効な情報の場合' do
      let(:user_email) { 'test@example.com' }
      let(:user_password) { 'password' }
      let(:password_confirmation) { 'password' }
      let(:user_name) { 'Test User' }

      it '成功メッセージが表示されること' do
        expect(page).to have_content('アカウント登録が完了しました。')
      end

      it 'カレンダーにリダイレクトされること' do
        expect(current_path).to eq(user_diaries_path(User.last))
      end
    end

    context '無効な情報の場合' do
      let(:user_email) { 'invalid' }
      let(:user_password) { 'password' }
      let(:password_confirmation) { 'password' }
      let(:user_name) { '' }

      it 'エラーメッセージが表示されること' do
        expect(page).to have_content('エラー')
      end

      it '同じ登録ページに留まること' do
        expect(page).to have_current_path(user_registration_path)
      end
    end
  end
end
