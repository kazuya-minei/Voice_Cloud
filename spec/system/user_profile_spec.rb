require 'rails_helper'

RSpec.feature "user_profile", type: :system do

  let!(:kazuya){ create(:user, name: 'kazuya', email: 'kazuya@test.com') }
  let!(:kazuma){ create(:user, name: 'kazuma', email: 'kazuma@test.com') }

  describe 'update' do
    context '本人の場合' do
      background do 
        login_as kazuya
        visit edit_user_path kazuya	
      end

      it 'プロフィール編集ページに遷移できる' do
        expect(page).to have_content 'プロフィール編集'
      end

      it '正常に編集出来る' do
        fill_in 'user[name]', with: 'kazuya minei'
        fill_in 'user[introduction_text]', with: 'よろしくおねがいします'
        find('#editing').click
        expect(page).to have_content 'kazuya mineiさんの情報を更新しました'
        expect(page).to have_content 'kazuya minei'
        expect(page).to have_content 'よろしくおねがいします'
      end

      it '紹介文は150文字以内でなければいけない' do
        fill_in 'user[introduction_text]', with: 'a' * 151
        find('#editing').click
        expect(page).to have_content '紹介文は150文字以内で入力してください'
      end
    end

    context "本人ではない場合" do
      background do
        login_as kazuma
        visit edit_user_path kazuya
      end

      it 'ホームページにリダイレクトされる' do
        expect(current_path).to eq root_path
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        visit edit_user_path kazuya
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end