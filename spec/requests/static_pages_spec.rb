require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  it "ホーム画面の表示に成功" do
    get root_path
    expect(response).to have_http_status(200)
  end
end