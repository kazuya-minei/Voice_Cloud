# require 'rails_helper'

# RSpec.describe "WorkLikes", type: :request do
#   let! (:user)  { create(:user) }
#   let! (:user2) { create(:user) }
#   let! (:work)  { create(:work, user: user) }
#   let! (:like) { create(:work_like, user: user, work: work) }

#   describe "#create" do 
#     context "ログインしてない場合" do
#       before { post create_worklike_path(work) }

#       it "ログイン画面にリダイレクトされる" do
#         expect(response).to redirect_to new_user_session_path
#       end
#     end

#     context "ログイン済みの場合" do
#       before { sign_in user }

#       it "正常にお気に入りできる", js: true do
#         expect do
#           post create_worklike_path(work)
#         end.to change { work.workLikes.count }.by(1)
#       end
#     end
#   end

# end
