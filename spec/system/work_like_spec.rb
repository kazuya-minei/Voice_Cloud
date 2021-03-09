require 'rails_helper'

RSpec.feature "work_like", type: :system, js: true do
  let!(:kazuya){ create(:user, name: 'kazuya', email: 'kazuya@test.com') }
  let!(:kazuma){ create(:user, name: 'kazuma', email: 'kazuma@test.com') }
  let!(:work){ create(:work, user: kazuya) }

  describe '#create' do
    context 'ログインしていない場合' do
      it 'お気に入りボタンが表示されない' do
        visit works_path
        expect(page).to_not have_content "お気に入り"
      end
    end 

    context 'ログイン済みの場合' do
      before do
        login kazuya 
        visit works_path
      end

      # it '「お気に入り」ボタンが表示されている' do
      #   expect(page).to have_content "お気に入り"
      # end

      # # it 'クリックで「お気に入り済み」に変化' do
      #   click_link 'お気に入り'
      #   expect(page).to have_content "お気に入り済み"
      # end

      # it '自身のプロフィールページから行けるお気に入りお題ページに追加されている' do
      #   click_link 'お気に入り'
      #   expect(page).to have_content "お気に入り済み"
      #   visit user_path(kazuya)
      #   click_link 'お気に入りしたお題'
      #   expect(page).to have_content work.title
      #   expect(page).to have_content work.content
      #   expect(page).to have_content "お気に入り済み"
      # end
    end
  end

  # describe '#destroy' do
  #   before do 
  #     login kazuya
  #     visit works_path 
  #     click_link 'お気に入り'
  #     expect(page).to have_content "お気に入り済み"
  #   end

  #   it '「お気に入り済み」をクリックで「お気に入り」に変化' do
  #     click_link 'お気に入り済み' 
  #     expect(page).to have_content "お気に入り"
  #   end
  # end
end