class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "ログインしました"
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = "メールアドレスかパスワードが違います"
      render 'new'
    end
  end

  def destroy
    flash[:success] = "ログアウトしました"
    log_out if logged_in?
    redirect_to root_url
  end

end
