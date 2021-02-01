require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup 
    @user = users(:minei)
  end

  test "User information edit failure" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: {name: "",
                                            email: "damena@mail..com",
                                         password: "passwordga",
                            password_confirmation: "tigauyo" } }               
    assert_template 'users/edit'
  end

  test "Successful editing of user information" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "kazuya minei",
                                             email: "minei@foo.com",} }
    assert_redirected_to @user
  end
  
end
