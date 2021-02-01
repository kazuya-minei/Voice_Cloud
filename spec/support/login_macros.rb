module LoginMacros

  def login(user)
    visit login_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: 'password'
    check 'ログインしたままにする'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
  end

  def logout(user)
    visit login_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
    visit root_path
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました'
  end

  def sign_in_as(user)
    post login_path, params: { session: { email: user.email,
                                        password: user.password } }
  end
  
end