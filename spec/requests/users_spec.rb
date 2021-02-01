require 'rails_helper'

RSpec.describe "Users", type: :request do

  let! (:user)  { create(:user) }
  let! (:user2) { create(:user) }
  let! (:admin) { create(:user, admin: true) }
  let  (:user_params) { attributes_for(:user) }
  let  (:invalid_user_params) { attributes_for(:user, name: "") }

  describe "#index" do
    it "正常にレスポンスが返ってくる" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "#show" do
    it "正常にレスポンスが返ってくる" do
      get user_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe "#new" do
    it "正常にレスポンスが返ってくる" do
      get new_user_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "登録成功" do
      it "正常にレスポンスが返ってくる" do
        post users_path, params: {user: user_params }
        expect(response).to have_http_status(302)
      end
      it "登録成功でユーザーが一人増える" do
        expect do
          post users_path, params: {user: user_params }
        end.to change(User, :count).by(1)
      end
      it "リダイレクトされる" do
        post users_path, params: {user: user_params }
        expect(response).to redirect_to root_path
      end
    end

    context "登録失敗" do
      it "正常にレスポンスが返ってくる"  do
        post users_path, params: {user: invalid_user_params}
        expect(response).to have_http_status(200)
      end
      it "ユーザー数は増えない" do
        expect do
          post users_path, params: {user: invalid_user_params}
        end.to change(User, :count).by(0)        
      end
      it "フォームがそのまま表示される" do
        post users_path, params: {user: invalid_user_params}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#edit" do
    context "本人の場合" do
      before do
        sign_in_as user
        get edit_user_url user
      end

      it "正常にレスポンスが返ってくる"  do
        expect(response).to have_http_status(200)
      end
    end

    context "本人ではない場合" do
      before do
        sign_in_as user2
        get edit_user_path user
      end

      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
    end

    context "ログインしてない場合" do
      before do
        get edit_user_path user
      end
      it "正常にレスポンスが返ってくる"  do
        expect(response).to have_http_status(302)
      end
      it "ログインフォームへリダイレクトする" do
        expect(response).to redirect_to login_path
      end
    end
  end

  # describe "PUT #update" do
  # end

  describe "DELETE #destroy" do
    context "権限がない場合" do
      before do
        sign_in_as user
        delete user_path user2
      end

      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end

      it "削除に失敗する" do
        expect do
          delete user_path user2
        end.to change(User, :count).by(0)  
      end
    end

    context "管理者の場合" do
      before do
        sign_in_as admin
      end

      it "正常にレスポンスが返ってくる" do
        delete user_path user
        expect(response).to have_http_status(302)
      end

      it "削除に成功する" do
        expect do
          delete user_path user2
        end.to change(User, :count).by(-1)
      end
    end
  
  end

end