require 'rails_helper'

RSpec.feature "work", type: :system do

  let!(:kazuya){ create(:user, name: 'kazuya', email: 'kazuya@test.com') }
  let!(:kazuma){ create(:user, name: 'kazuma', email: 'kazuma@test.com') }
  let!(:work){ create(:work, user: kazuya) }

  describe 'create(新規作成)' do

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        visit new_work_path
        expect(page).to have_content 'ログインしてください'
      end
    end

    context '入力が正しい場合' do
      background do
        login kazuya 
        visit new_work_path
        fill_in 'work[title]',   with: 'work_title'
        fill_in 'work[content]', with: 'a' * 1000
      end

      it '投稿に成功する'  do
        find('#submission').click
        expect(page).to have_content 'お題を投稿しました'
      end
    end

    context '入力が不正な場合' do

      background do
        login kazuya
        visit new_work_path
      end

      it 'タイトルは空だと投稿失敗' do
        fill_in 'work[title]', with: ''
        find('#submission').click
        expect(page).to have_content 'タイトルを入力してください'
      end

      it 'タイトルは13文字以上は投稿失敗' do
        fill_in 'work[title]', with: 'a' * 13
        find('#submission').click
        expect(page).to have_content 'タイトルは12文字以内で入力してください'
      end

      it 'お題詳細は空だと投稿失敗' do
        fill_in 'work[content]', with: ''
        find('#submission').click
        expect(page).to have_content 'お題詳細を入力してください' 
      end

      it '以来詳細は1001文字以上は投稿失敗' do
        fill_in 'work[content]', with: 'a' * 1001
        find('#submission').click
        expect(page).to have_content 'お題詳細は1000文字以内で入力してください'
      end
    end
  end

  describe 'update(編集)' do

    context '本人の場合' do
      background do
        login kazuya
        visit edit_work_path work
      end

      it '詳細ページに編集リンクが表示される' do
        visit work_path work
        expect(page).to have_content '編集する'
      end

      it '編集ページに遷移できる' do
        expect(page).to have_content 'タイトル'
      end

      it '正常に更新できる' do
        fill_in 'work[title]', with: 'change title'
        fill_in 'work[content]', with: 'change work content' 
        find('#update').click
        expect(page).to have_content '募集内容を編集しました'
        expect(page).to have_content 'change title'
        expect(page).to have_content 'change work content'
      end

      it 'タイトル、以来詳細が空だと編集失敗' do
        fill_in 'work[title]', with: ''
        fill_in 'work[content]', with: ''
        find('#update').click
        expect(page).to have_content 'タイトルを入力してください'
        expect(page).to have_content 'お題詳細を入力してください'
      end

    end

    context '本人ではない場合' do
      background do
        login kazuma
      end

      it '詳細ページに編集リンクは表示されない' do
        visit work_path work
        expect(page).to_not have_content '編集する'
      end

      it 'ホームページにリダイレクトされる' do
        visit edit_work_path work
        expect(current_path).to eq root_path
      end
    end
  end

  describe 'destroy(削除)' do

    context '本人の場合' do
      background do
        login kazuya
        visit work_path work
      end

      it '詳細ページに削除リンクが表示される' do
        expect(page).to have_content '削除する'
      end

      it '正常に削除され、一覧ページにリダイレクトされる' do
        click_link '削除する'
        expect(page).to have_content 'お題を削除しました'
        expect(current_path).to eq works_path
      end
    end

    context '本人ではない場合' do
      background do
        login kazuma
        visit work_path work
      end

      it '詳細ページに削除リンクは表示されない' do
        expect(page).to_not have_content '削除する'
      end
    end 
  end
end
  