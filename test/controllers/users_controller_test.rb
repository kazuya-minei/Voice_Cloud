require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:minei)
    @otheruser = users(:nakamura)
  end

  test "should get new" do
    get users_new_url
    assert_response :success
  end

  test "Pages that can only be accessed by logging in" do
    get edit_user_path(@user)
    assert_redirected_to login_url
    assert_not flash.empty?
    patch user_path(@user), params: { user: { name: @user.name,
                                             email: @user.email } }
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "You can't edit another user's information." do
    log_in_as(@otheruser)
    get edit_user_path(@user)
    assert_redirected_to root_url
    patch user_path(@user), params: {user: {name: @user.name,
                                           email: @user.email } }
    assert_redirected_to root_url
  end

  test "Deleting a user requires login." do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "You can't delete a user without permission." do
    log_in_as(@otheruser)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "Users can be deleted if they are logged in and have permissions." do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@otheruser)
    end
    assert_redirected_to users_url
  end

end
