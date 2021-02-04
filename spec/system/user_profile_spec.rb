require 'rails_helper'

RSpec.feature "user_profile", type: :system do

  let!(:kazuya){ create(:user, name: 'kazuya', email: 'kazuya@test.com') }
  let!(:kazuma){ create(:user, name: 'kazuma', email: 'kazuma@test.com') }

  describe 'update' do
    context '本人の場合' do
      background do 
        login kazuya
        visit edit_user_path kazuya	
      end

      it 'プロフィール編集ページに遷移できる' do
        expect(page).to have_content 'プロフィール編集'
      end

      it '正常に編集出来る' do
        fill_in 'user[name]', with: 'kazuya minei'
        fill_in 'user[introduction_text]', with: 'よろしくおねがいします'
        find('#editing').click
        expect(page).to have_content 'プロフィールを編集しました'
        expect(page).to have_content 'kazuya minei'
        expect(page).to have_content 'よろしくおねがいします'
      end

      it 'パスワードは入力しなくても編集できる' do
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        find('#editing').click
        expect(page).to have_content 'プロフィールを編集しました'
      end

      it '紹介文は150文字以内でなければいけない' do
        fill_in 'user[introduction_text]', with: 'a' * 151
        find('#editing').click
        expect(page).to have_content '紹介文は150文字以内で入力してください'
      end
    end

    context "本人ではない場合" do
      background do
        login kazuma
        visit edit_user_path kazuya
      end

      it 'ホームページにリダイレクトされる' do
        expect(current_path).to eq root_path
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        visit edit_user_path kazuya
        expect(current_path).to eq login_path
      end
    end
  end
end