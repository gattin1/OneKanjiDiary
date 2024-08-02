# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ユーザーセッション', type: :system do
  let!(:user) { User.create(email: 'test@example.com', password: 'password', name: 'Test User') }

  before do
    driven_by(:rack_test)
  end

  context 'ユーザーログイン' do
    it '有効な資格情報でログインできること' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      expect(page).to have_content('ログインしました。')
    end

    it 'ログイン後にルートパスにリダイレクトされること' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      expect(current_path).to eq(root_path)
    end

    it '無効な資格情報ではログインできないこと' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'wrongpassword'
      click_button 'ログイン'

      expect(page).to have_content('メールアドレスまたはパスワードが違います。')
    end

    it 'ログイン失敗後に再度ログインページが表示されること' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'wrongpassword'
      click_button 'ログイン'

      expect(current_path).to eq(new_user_session_path)
    end
  end

  context 'ユーザーログアウト' do
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    it 'ログアウトすると成功メッセージが表示されること' do
      visit root_path
      click_link 'ログアウト'

      expect(page).to have_content('ログアウトしました。')
    end

    it 'ログアウト後にルートパスにリダイレクトされること' do
      visit root_path
      click_link 'ログアウト'

      expect(current_path).to eq(root_path)
    end
  end
end
