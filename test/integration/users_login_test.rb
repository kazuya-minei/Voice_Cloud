require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:minei)
  end

  test "login with invalid information" do
    get login_path  #ログインフォームにアクセス
    assert_template 'sessions/new' #ログインフォームページが表示されている
    post login_path, params: { session: { email: @user.email, password: "foobar" } }  #わざと失敗するログイン処理を行う
    assert_not is_logged_in? #ログインしてないはず。is_logged_inメソッドがfalseで成功。
    assert_template 'sessions/new'  #ログインに失敗したらまたログインフォームが表示されている
    assert_not flash.empty?  #flashが表示されている
    get root_path  #別のページに遷移
    assert flash.empty?  #別のページに遷移したらフラッシュメッセージは消えているべき
  end

  test "login with valid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: { email: @user.email, 
                                      password: 'password'}}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", new_work_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", new_work_path,         count: 0
    assert_select "a[href=?]", users_path,            count: 0
    assert_select "a[href=?]", user_path(@user),      count: 0
    assert_select "a[href=?]", edit_user_path(@user), count: 0
    assert_select "a[href=?]", logout_path,           count: 0
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", signup_path
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')#チェックしてログイン
    assert_not_empty cookies[:remember_token]  #cookiesのトークンは空になってないはず
  end

  test "login without remembering" do
    # cookieを保存してログイン
    log_in_as(@user, remember_me: '1')#チェックしてログイン
    delete logout_path #ログアウト
    # cookieを削除してログイン
    log_in_as(@user, remember_me: '0')#チェックしないでログイン
    assert_empty cookies[:remember_token] #cookiesのトークンは空になっているはず
  end

end
