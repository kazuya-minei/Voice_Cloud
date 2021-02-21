class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: %i(show edit update destroy following followers worklikes voicelikes)
  before_action :correct_user, only: %i(edit update)

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @works = @user.works.paginate(page: params[:page])
  end

  def edit
    if @user != current_user
      redirect_to root_path, alert: '権限がありません'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user
      flash[:notice] = "#{@user.name}さんの情報を更新しました"
    else
      flash[:user] = @user
      flash.now[:error_messages] = @user.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    if current_user.admin?
      @user.destroy
      flash[:success] = "ユーザーを削除しました"
      redirect_to users_url
    else
      redirect_to(root_url)
    end
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
  end

  def worklikes
    @worklikes = @user.workLikes
  end

  def voicelikes 
    @voicelikes = @user.voiceLikes
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :avatar, :voice_s, 
                                   :introduction_text)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user == @user
    end

end
