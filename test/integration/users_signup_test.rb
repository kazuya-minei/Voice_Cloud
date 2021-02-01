require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path  #アクセス
    assert_no_difference 'User.count' do  #これより下のコードが実行されてもUserの数は変わらないべき
      post users_path, params: { user: { name:  "",  #POSTリクエストを直接送信
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'  #失敗したらまた登録フォームページが表示されてるはず
  end

  test "valid signup information" do
    get signup_path #アクセス
    assert_difference 'User.count', 1 do #以下のコードを実行したらUserデータの数が1つ増えてるはず
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
  end

end
