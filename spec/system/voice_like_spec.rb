require 'rails_helper'

RSpec.feature "voice_like", type: :system, js: true do
  let!(:kazuya){ create(:user, name: 'kazuya', email: 'kazuya@test.com') }
  let!(:kazuma){ create(:user, name: 'kazuma', email: 'kazuma@test.com') }
  let!(:work){ create(:work, user: kazuya) }
  let!(:voice){ create(:voice, user: kazuya, work: work) }

  describe '#create' do
    context 'ログインしていない場合' do
      it 'いいねボタンが表示されない' do
        visit voices_path
        expect(page).to_not have_content "いいね"
      end
    end 

    context 'ログイン済みの場合' do
      # before do
      #   login kazuya 
      #   visit voices_path
      # end

      # it '「いいね」ボタンが表示されている' do
      #   expect(page).to have_content "いいね"
      # end

      # it 'クリックで「いいね済み」に変化' do
      #   click_link 'いいね'
      #   expect(page).to have_content "いいね済み"
      # end

      # it '自身のプロフィールページから行けるいいねボイスページに追加されている' do
      #   click_link 'いいね'
      #   expect(page).to have_content "いいね済み"
      #   visit user_path(kazuya)
      #   click_link 'いいねしたボイス'
      #   expect(page).to have_content voice.work.title
      #   expect(page).to have_content voice.work.content
      #   expect(page).to have_content "いいね済み"
      # end
    end
  end

  describe '#destroy' do
    # before do 
    #   login kazuya
    #   visit voices_path 
    #   click_link 'いいね'
    #   expect(page).to have_content "いいね済み"
    # end
  
    # it '「いいね済み」をクリックで「いいね」に変化' do
    #   click_link 'いいね済み' 
    #   expect(page).to have_content "いいね"
    # end
  end
end