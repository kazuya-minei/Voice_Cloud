require 'rails_helper'

RSpec.feature "sign_up", type: :system do

  background do
    visit new_user_path
    fill_in 'user[name]',                 with: 'kazuya'
    fill_in 'user[email]',                with: 'kazuya@test.com'
    fill_in 'user[password]',             with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
  end

  describe '入力が正しい場合' do
    it '登録に成功する' do
      find('#signup').click
      expect(page).to have_content "登録が完了しました"
    end
  end

  describe '入力が不正、' do

    context '名前が空欄の場合' do
      it '登録失敗する' do
        fill_in 'user[name]', with: ''
        find('#signup').click
        expect(page).to have_content '名前を入力してください'
      end
    end

    context '名前が文字数オーバー場合' do
      it '登録失敗する' do
        fill_in 'user[name]', with: 'a' * 51
        find('#signup').click
        expect(page).to have_content '名前は50文字以内で入力してください' 
      end
    end

    context 'メールアドレスが空欄の場合' do
      it '登録失敗する' do
        fill_in 'user[email]', with: ''
        find('#signup').click
        expect(page).to have_content 'メールアドレスを入力してください'
      end
    end

    context 'メールアドレスが文字数オーバーの場合' do
      it '登録失敗する' do
        fill_in 'user[email]', with: 'a' * 256 + '@test.com'
        find('#signup').click
        expect(page).to have_content 'メールアドレスは255文字以内で入力してください'
      end
    end

    context 'メールアドレスのフォーマットが不正な場合' do
      it '登録失敗する' do
        fill_in 'user[email]', with: 'abc_@__@/.com'
        find('#signup').click
        expect(page).to have_content 'メールアドレスは不正な値です'
      end
    end

    context 'メールアドレスが重複した場合' do
      before { create(:user, email: 'kazuya@test.com') }

      it '登録失敗' do
        find('#signup').click
        expect(page).to have_content 'メールアドレスはすでに存在します'
      end
    end

    context 'パスワードが空欄の場合' do
      it '登録失敗' do
        fill_in 'user[password]', with: ''
        find('#signup').click
        expect(page).to have_content 'パスワードを入力してください'
      end
    end

    context 'パスワードの文字数が少ない場合' do
      it '登録失敗' do
        fill_in 'user[password]', with: 'a' * 5
        find('#signup').click
        expect(page).to have_content 'パスワードは6文字以上で入力してください'
      end
    end

    context 'パスワードと確認の値が一致しない場合' do
      it '登録失敗' do
        fill_in 'user[password_confirmation]', with: 'notpassword'
        find('#signup').click
        expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
      end
    end
  end
end