require 'rails_helper'

RSpec.describe "Voices", type: :request do
  let! (:user)  { create(:user) }
  let! (:user2) { create(:user) }
  let! (:work)  { create(:work, user: user) }
  let! (:voice) { create(:voice, user: user, work: work) }
  let! (:voice2) { create(:voice, user: user, work: work) }
  let  (:voice_params) { attributes_for(:voice) }

  describe "#index" do 
    context "ログインしていない時" do

      before { get voices_path }

      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end 
      it "ログインページにリダイレクトされる" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済みの時" do

      before do
        sign_in user
        get voices_path
      end

      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(200)
      end
    end
  end

  # describe "POST #create" do
  #   context "ログインしていない時" do
  #     before { post work_voices_path, params: { post: voice } }

  #     it "正常にレスポンスが返ってくる" do
  #       expect(response).to have_http_status(302)
  #     end 
  #     it "ログインページにリダイレクトされる" do
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #     it "Voiceデータは増えない" do
  #       expect do
  #         post work_voices_path, params: { voice: voice_params}
  #       end.to change(Voice, :count).by(0) 
  #     end
  #   end
  # end

  describe "#destroy" do 

    context "ログインしてない場合" do

      before { delete voice_path voice }
      
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "ログインページにリダイレクトされる" do
        expect(response).to redirect_to new_user_session_path
      end
      it "Voiceデータの数は変わらない" do
        expect do
          delete voice_path voice
        end.to change(Voice, :count).by(0)
      end
    end

    context "本人ではない場合" do
      before do
        sign_in user2
        delete voice_path voice
      end
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "Homeへリダイレクトされる" do
        expect(response).to redirect_to root_path
      end
      it "Voiceデータの数は変わらない" do
        expect do
          delete voice_path voice
        end.to change(Voice, :count).by(0)
      end
    end

    context "本人の場合" do
      before do
        sign_in user
        delete voice_path voice
      end
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "元いたお題詳細ページへリダイレクトされる" do
        expect(response).to redirect_to work_path(work)
      end
      it "削除に成功する" do
        expect do
          delete voice_path voice2 
        end.to change(Voice, :count).by(-1)
      end
    end

  end

end