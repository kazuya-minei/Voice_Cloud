class VoicesController < ApplicationController
  before_action :logged_in_user, only: [:show, :create, :destroy]
  before_action :correct_user, only: [:destroy]


  def index
    @voices = Voice.paginate(page: params[:page])
  end

  def show
    @voice = Voice.find(params[:id])
    @comments = @voice.comments
    @comment = current_user.comments.new
  end

  def create
    @voice = current_user.voices.new(voice_params)
    if @voice.save
      flash[:notice] = "ボイスを投稿しました"
      redirect_back(fallback_location: root_path) #一つ前のページへリダイレクトさせる。
    else
      flash[:alert] = "データが選択されていないか、拡張子が正しくありません"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    work = @voice.work
    @voice.destroy
    flash[:notice] = "ボイスを削除しました"
    redirect_to work_path(work)
  end

  private

    def voice_params
      params.require(:voice).permit(:work_id, :voice_data)
    end
    
    def correct_user
      @voice = Voice.find_by(id: params[:id])
      redirect_to root_url unless @voice.user_id == current_user.id
    end

end
