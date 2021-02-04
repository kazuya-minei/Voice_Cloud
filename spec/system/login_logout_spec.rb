# require 'rails_helper'

# RSpec.feature 'login', type: :system do
  
#   given! (:user) { create( :user, name: 'minei', email: 'minei@test.com' ) }

#   background do
#     visit '/login'
#     fill_in 'session[email]', with: 'minei@test.com'
#     fill_in 'session[password]', with: 'password'
#   end
  
#   feature '入力が正しい場合' do
#     scenario '正常にログインできる' do
#       click_button 'ログイン'
#       expect(page).to have_content 'ログインしました'
#     end
#   end
# end
require 'rails_helper'

RSpec.feature "login_logout", type: :system do
  given! (:user) { create( :user, name: 'minei', email: 'minei@test.com' ) }
#  background do
#    User.create!(name: "minei", email: "minei@test.com", password: 'password')
#  end

  background do
    visit login_path
    fill_in 'session[email]', with: 'minei@test.com'
    fill_in 'session[password]', with: 'password'
  end

  scenario '正常にログインできる' do
    find('#login').click
    expect(page).to have_content 'ログインしました'
  end

  scenario 'メールアドレスが不正だとログインできない' do
    fill_in 'session[email]', with: 'not-minei@test.com'
    find('#login').click
    expect(page).to have_content 'メールアドレスかパスワードが違います'
  end

  scenario 'パスワードが不正だとログインできない' do
    fill_in 'session[password]', with: 'notpassword'
    find('#login').click
    expect(page).to have_content 'メールアドレスかパスワードが違います'
  end

  scenario 'ログアウトができる' do
    find('#login').click
    expect(page).to have_content 'ログインしました'
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました'
  end    

end