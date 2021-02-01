require 'rails_helper'

RSpec.describe "Works", type: :request do
  let! (:user)  { create(:user) }
  let! (:user2) { create(:user) }
  let! (:work)  { create(:work, user: user) }
  let! (:work2)  { create(:work, user: user) }
  let  (:work_params) { attributes_for(:work) }
  let  (:new_work_parms) { { work: { title: "newtitle", content: "newcontent" } } }


  describe "#index" do
    before { get works_path }

    it "正常にレスポンスが返ってくる" do
      expect(response).to have_http_status(200)
    end
  end

  describe "#show" do

    context "ログインしてない場合" do
      before  { get work_path(work) }

      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end 
      it "ログインページにリダイレクトされる" do
        expect(response).to redirect_to login_path
      end
    end

    context "ログイン済の場合" do
      before do
        sign_in_as user
        get work_path(work)
      end

      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#new" do

    context "ログインしていない場合" do
      before { get new_work_path }

      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end 
      it "ログインページにリダイレクトされる" do
        expect(response).to redirect_to login_path
      end
    end

    context "ログイン済の場合" do
      before do
        sign_in_as user
        get work_path(work)
      end

      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST #create" do
    context "ログインしていない場合" do
      before { post works_path, params: { work: work } }
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "ログインページにリダイレクトされる" do
        expect(response).to redirect_to login_path
      end
      it "Workデータは増えない" do
        expect do
          post works_path, params: { work: work_params}
        end.to change(Work, :count).by(0) 
      end
    end

    context "ログイン済の場合" do
      before do
        sign_in_as user
        post works_path, params: { work: work_params}
      end
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "一覧ページにリダイレクトされる" do
        expect(response).to redirect_to works_path
      end
      it "Workデータが１つ増える" do
        expect do
          post works_path, params: { work: work_params}
        end.to change(Work, :count).by(1)  
      end      
    end
  end

  describe "#edit" do 
    context "ログインしていない場合" do
      before { get edit_work_path work }
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "ログインページにリダイレクトされる" do
        expect(response).to redirect_to login_path
      end
    end
    
    context "本人ではない場合" do
      before do
        sign_in_as user2
        get edit_work_path work
      end
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "Homeへリダイレクトされる" do
        expect(response).to redirect_to root_path
      end
    end

    context "本人の場合" do
      before do
        sign_in_as user
        get edit_work_path work
      end
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(200)
      end
      it "Work編集ページが表示される" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "PUT #update" do
    context "ログインしていない場合" do
      before { patch '/works/' + work.id.to_s, params: new_work_parms }
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "ログインページにリダイレクトされる" do
        expect(response).to redirect_to login_path
      end
    end
    context "本人ではない場合" do
      before do
        sign_in_as user2
        patch '/works/' + work.id.to_s, params: new_work_parms 
      end
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "Homeへリダイレクトされる" do
        expect(response).to redirect_to root_path
      end
    end
    context "本人の場合" do
      before do
        sign_in_as user
        patch '/works/' + work.id.to_s, params: new_work_parms
      end
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "Work詳細ページにリダイレクトされる" do
        expect(response).to redirect_to work_path work
      end
      it "内容が変更されている" do
        work = Work.find_by(title: "newtitle")
        expect(work.title).to eq "newtitle"
        expect(work.content).to eq "newcontent"
      end
    end
  end

  describe "#destroy" do
    context "ログインしてない場合" do
      before { delete work_path work }
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "ログインページにリダイレクトされる" do
        expect(response).to redirect_to login_path
      end
      it "Workデータの数は変わらない" do
        expect do
          delete work_path work
        end.to change(Work, :count).by(0)
      end
    end

    context "本人ではない場合" do
      before do
        sign_in_as user2
        delete work_path work
      end
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "Homeへリダイレクトされる" do
        expect(response).to redirect_to root_path
      end
      it "Workデータの数は変わらない" do
        expect do
          delete work_path work
        end.to change(Work, :count).by(0)
      end
    end

    context "本人の場合" do
      before do
        sign_in_as user
        delete work_path work
      end
      it "正常にレスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "一覧ページへリダイレクトされる" do
        expect(response).to redirect_to works_path
      end
      it "削除に成功する" do
        expect do
          delete work_path work2 
        end.to change(Work, :count).by(-1)
      end
    end
  end
end