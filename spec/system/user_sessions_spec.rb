require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常なとき' do
      it 'ログイン処理が成功する' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
        expect(page).to have_content 'ログインしました'
        expect(current_path).to eq fishes_path
      end
    end

    context 'フォームが未入力の時' do
      it 'ログイン処理が失敗する' do
        visit login_path
        fill_in 'メールアドレス', with: 'fraudulent@com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
        expect(page).to have_content 'ログインできませんでした'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリックしたとき' do
      it 'ログアウト処理が成功する' do
        login_as(user)
        find('#js-user-menu-button').click
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(current_path).to eq login_path
      end
    end
  end
end
