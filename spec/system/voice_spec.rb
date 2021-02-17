require 'rails_helper'

RSpec.feature "voice", type: :system do
  let!(:kazuya){ create(:user, name: 'kazuya', email: 'kazuya@test.com') }
  let!(:kazuma){ create(:user, name: 'kazuma', email: 'kazuma@test.com') }
  let!(:work){ create(:work, user: kazuya) }

  describe "create" do
    context "ログインしていない場合" do
      it "ログインページにリダイレクトされる" do
        visit work_path(work) 
        expect(page).to have_content 'ログインしてください'
      end
    end

    context "ログイン済みの場合" do
      background do
        login kazuya
        visit work_path(work)
      end

      it "アクセスできる" do
        expect(page).to have_content work.title
      end

      it "正しい拡張子のファイルを選択、投稿に成功する" do
        attach_file 'voice[voice_data]', "#{Rails.root}/spec/fixtures/testvoice.mp3"
        find('#submission').click
        expect(page).to have_content 'ボイスを投稿しました'
      end
      
      it "不正な拡張子のファイルを選択、投稿に失敗する" do
        attach_file 'voice[voice_data]', "#{Rails.root}/spec/fixtures/testnotvoice.png"
        find('#submission').click
        expect(page).to have_content 'データが選択されていないか、拡張子が正しくありません'
      end

      it "何もファイルを選択しなかった場合、エラーメッセージが表示される" do
        find('#submission').click
        expect(page).to have_content 'データが選択されていないか、拡張子が正しくありません'
      end
    end
  end

  describe "destroy" do
    background do
      login kazuya
      visit work_path(work)
      attach_file 'voice[voice_data]', "#{Rails.root}/spec/fixtures/testvoice.mp3"
      find('#submission').click
    end

    context "本人の場合" do

      it "削除リンクが表示されている" do
        expect(page).to have_content 'ボイスを削除する'
      end

      it "リンクをクリックで削除できる", js: true do
        click_link 'ボイスを削除する'
        expect{
          expect(page.accept_confirm).to eq "ボイスを削除しますか?"
          expect(page).to have_content "ボイスを削除しました"
        }.to change(Voice, :count).by(-1)
      end
    end

    context "本人ではない場合" do
      background do
        click_link 'ログアウト'
        login kazuma
        visit work_path(work)
      end

      it "削除リンクは表示されない" do
        expect(page).to_not have_content 'ボイスを削除する'
      end
    end
  end
end