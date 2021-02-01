require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:minei)
    @otheruser = users(:nakamura)
  end

  test "You can access the index page even if you are not logged in." do #ログインしてなくてもユーザー一覧ページは見れる
    get users_path
    assert_template 'users/index'
  end

  test "Testing pagination" do 
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'  #paginationクラスを与えたdivタグが存在するはず
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name #それぞれのユーザーが表示されてい、それぞれのプロフィールページへのリンクになっている
    end
  end

  test "Administrators can handle delete links." do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    users = User.paginate(page: 1)
    users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @user
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do 
      delete user_path(@otheruser)
    end
  end

  test "Only administrators can see the delete link." do
    log_in_as(@otheruser)
    get users_path
    assert_template 'users/index'
    assert_select 'a', text: 'delete', count: 0
  end

end
