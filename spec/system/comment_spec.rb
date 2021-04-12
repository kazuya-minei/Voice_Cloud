require 'rails_helper'

RSpec.feature "comment", type: :system do
  let!(:kazuya) { create(:user, name: 'kazuya', email: 'kazuya@test.com') }
  let!(:kazuma) { create(:user, name: 'kazuma', email: 'kazuma@test.com') }
  let!(:work)   { create(:work, user: kazuya) }
  let!(:voice)  { create(:voice, user: kazuya, work: work) }
  let!(:comment){ create(:comment, user: kazuya, voice: voice) }

  describe "#create" do
    context "ログインしていない場合" do
      it "ログインページにリダイレクトされる" do
        visit voice_path(voice) 
        expect(page).to have_content 'ログインしてください'
      end
    end

    context "ログイン済みの場合" do
      background do
        login_as kazuya
        visit voice_path(voice)
      end

      it "アクセスできる" do
        expect(page).to have_content work.title
        expect(page).to have_content "コメントする"
      end

      it "コメントを投稿できる" do
        fill_in 'comment[comment]', with: 'cool!!'
        find('#submission').click
        expect(page).to have_content 'cool!!'
        expect(page).to have_content 'コメントしました'
      end
      
      it "140字以上のコメントは投稿できない" do
        fill_in 'comment[comment]', with: 'a' * 141
        find('#submission').click
        expect(page).to have_content 'コメントは140文字以内で入力してください'
      end

      it "コメント未入力ではエラーとなる" do
        find('#submission').click
        expect(page).to have_content 'コメントを入力してください'
      end
    end

    context "別のユーザーの場合" do

    end
  end

  describe "#destroy" do

    context "本人の場合" do
      background do
        login_as kazuya
        visit voice_path(voice)
      end

      it "コメント削除リンクがある" do
        expect(page).to have_content "削除"
      end

      it "コメントした本人はそのコメントを削除できる", js: true do
        click_link '削除'
        expect{
          expect(page.accept_confirm).to eq "コメントを削除しますか?"
          expect(page).to have_content "コメントを削除しました"
        }.to change(Comment, :count).by(-1)
      end
    end

    context "本人ではない場合" do
      background do
        login_as kazuma
        visit voice_path(voice)
      end
      
      it "コメント削除リンクは見えない" do
        expect(page).to_not have_content "削除"
      end
    end
  end
  
end