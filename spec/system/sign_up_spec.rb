require 'rails_helper'

RSpec.feature "sign_up", type: :system do

  background do
    visit new_user_registration_path
    fill_in '名前',                 with: 'kazuya'
    fill_in 'メールアドレス',                with: 'kazuya@test.com'
    fill_in 'パスワード',             with: 'password'
    fill_in 'パスワード確認', with: 'password'
  end

  describe '入力が正しい場合' do
    it '登録に成功する' do
      find('#signup').click
      expect(page).to have_content "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
    end
  end

  describe '入力が不正、' do

    context '名前が空欄の場合' do
      it '登録失敗する' do
        fill_in '名前', with: ''
        find('#signup').click
        expect(page).to have_content '名前を入力してください'
      end
    end

    context '名前が文字数オーバー場合' do
      it '登録失敗する' do
        fill_in '名前', with: 'a' * 51
        find('#signup').click
        expect(page).to have_content '名前は50文字以内で入力してください' 
      end
    end

    context 'メールアドレスが空欄の場合' do
      it '登録失敗する' do
        fill_in 'メールアドレス', with: ''
        find('#signup').click
        expect(page).to have_content 'メールアドレスを入力してください'
      end
    end

    context 'メールアドレスが文字数オーバーの場合' do
      it '登録失敗する' do
        fill_in 'メールアドレス', with: 'a' * 256 + '@test.com'
        find('#signup').click
        expect(page).to have_content 'メールアドレスは255文字以内で入力してください'
      end
    end

    context 'メールアドレスのフォーマットが不正な場合' do
      it '登録失敗する' do
        fill_in 'メールアドレス', with: 'abc_@__@/.com'
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
        fill_in 'パスワード', with: ''
        find('#signup').click
        expect(page).to have_content 'パスワードを入力してください'
      end
    end

    context 'パスワードの文字数が少ない場合' do
      it '登録失敗' do
        fill_in 'パスワード', with: 'a' * 5
        find('#signup').click
        expect(page).to have_content 'パスワードは6文字以上で入力してください'
      end
    end

    context 'パスワードと確認の値が一致しない場合' do
      it '登録失敗' do
        fill_in 'パスワード確認', with: 'notpassword'
        find('#signup').click
        expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
      end
    end
  end
end