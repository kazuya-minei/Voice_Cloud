require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let! (:user)    { create(:user) }
  let! (:user2)   { create(:user) }
  let! (:work)    { create(:work, user: user) }
  let! (:voice)   { create(:voice, user: user, work: work) }
  let! (:comment) { create(:comment, user: user, voice: voice) }
  let! (:comment2){ create(:comment, user: user, voice: voice) }
  let  (:comment_params) { attributes_for(:comment) }

  describe "POST #create" do
  end

  describe "DELETE #destroy" do
    context "本人の場合" do
      before do
        sign_in user
        delete comment_path comment
      end
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "元いたボイス詳細ページへリダイレクトされる" do
        expect(response).to redirect_to voice_path(voice)
      end
      it "削除に成功する" do
        expect do
          delete comment_path comment2
        end.to change(Comment, :count).by(-1)
      end
    end
  end

end
