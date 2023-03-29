require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe '新規ユーザー登録をする。' do
    context 'フォームの入力値が正常なとき' do
      it 'ユーザー登録処理が成功する' do
        visit login_path
        click_link '新規登録'
        fill_in '名前', with: 'user_1'
        fill_in 'メールアドレス', with: 'example@co.jp'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/sample.jpg"
        fill_in '自己紹介', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'ユーザーを作成しました'
        expect(current_path).to eq root_path
        expect(page).to have_selector("img[src$='sample.jpg']")
      end
    end
    context 'フォームの入力値が正常でないとき' do
      it 'ユーザー登録処理が失敗する' do
        visit login_path
        click_link '新規登録'
        fill_in '名前', with: 'user_1'
        fill_in 'メールアドレス', with: 'fraudulent@com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/sample.jpg"
        fill_in '自己紹介', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'ユーザーを作成できませんでした'
        expect(current_path).to eq users_path
      end
    end
  end
end
