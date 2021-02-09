require 'rails_helper'

RSpec.feature "rekationship", type: :system do

  let!(:kazuya){ create(:user, name: 'kazuya', email: 'kazuya@test.com') }
  let!(:kazuma){ create(:user, name: 'kazuma', email: 'kazuma@test.com') }

  describe "ログインしていない場合" do

    background do
      visit user_path kazuya
    end
    it "フォロー一覧ページにアクセスできない" do
      click_link 'フォロー'
      expect(page).to have_content 'ログインしてください'
    end
    it "フォロワー一覧ページにアクセスできない" do
      click_link 'フォロワー'
      expect(page).to have_content 'ログインしてください'
    end
  end

  describe "ログイン中" do

    it "ユーザーをフォロー/フォロー解除できる", js: true do
      # kazuyaでログイン
      login kazuya  

      # kazumaをフォローしにいく
      visit user_path kazuma
      expect(page).to have_content 'kazuma'
      expect(page).to have_content '0 フォロワー'
      expect do
        click_button 'フォローする'
        expect(page).to have_content '1 フォロワー'
      end.to change(kazuya.following, :count).by(1) &
             change(kazuma.followers, :count).by(1)

      # 自分のマイページに移動し、kazumaが追加されているか確認
      visit user_path kazuya
      expect(page).to have_content 'kazuya'
      expect(page).to have_content '1 フォロー'
      click_link '1 フォロー'
      expect(current_path).to eq "/users/#{kazuya.id}/following"
      expect(page).to have_content 'kazuma'

      # フォローを解除する
      click_link 'kazuma'
      expect do
        click_button 'フォロー中'
        expect(page).to have_content '0 フォロワー'
      end.to change(kazuya.following, :count).by(-1) &
             change(kazuma.followers, :count).by(-1)

      # 自分のマイページに移動し、kazumaが削除されているか確認
      visit user_path kazuya
      expect(page).to have_content '0 フォロー'
      click_link '0 フォロー'
      expect(page).not_to have_content 'kazuma'
    end

    describe "フォロー/フォロワーの有無で一覧ページの表示が変わる" do
      context "フォロー/フォロワーが0の時" do
        background do
          login kazuya
          visit user_path kazuya
        end

        it "フォロワーがいない時「現在フォロワーはいません」と表示される" do
          expect(page).to have_content '0 フォロワー'
          click_link '0 フォロワー'
          expect(page).to have_content '現在フォロワーはいません'
        end
  
        it "誰もフォローしてない時「現在フォロー中のユーザーはいません」と表示される" do
          expect(page).to have_content '0 フォロー'
          click_link '0 フォロー'
          expect(page).to have_content '現在フォロー中のユーザーはいません'
        end
      end
    end
  end
end