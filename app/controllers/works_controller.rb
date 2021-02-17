class WorksController < ApplicationController
  before_action :logged_in_user, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @works = Work.paginate(page: params[:page])
  end

  def show
    @work = Work.find(params[:id])
    @voices = @work.voices
    @voice = current_user.voices.new
  end

  def new
    @work = current_user.works.build if user_signed_in?
  end

  def create
    @work = current_user.works.build(work_params)
    if @work.save
      flash[:notice] = "お題を投稿しました"
      redirect_to works_path
    else
      flash[:work] = @work
      flash.now[:error_messages] = @work.errors.full_messages
      render 'new'
    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if @work.update(work_params)
      flash[:notice] = "募集内容を編集しました"
      redirect_to @work
    else
      flash[:work] = @work
      flash.now[:error_messages] = @work.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @work.destroy
    flash[:notice] = "お題を削除しました"
    redirect_to works_url
  end

  private

    def work_params
      params.require(:work).permit(:title, :content)
    end

    def correct_user
      @work = current_user.works.find_by(id: params[:id])
      redirect_to root_url if @work.nil?
    end

end
