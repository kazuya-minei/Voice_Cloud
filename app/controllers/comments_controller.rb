class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:notice] = 'コメントしました'
      redirect_back(fallback_location: root_path)
    else
      flash[:comment] = @comment
      flash[:error_messages] = @comment.errors.full_messages
      redirect_back fallback_location: @comment.voice
    end
  end

  def destroy 
    voice = @comment.voice
    @comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to voice_path(voice)
  end

  private

    def comment_params
      params.require(:comment).permit(:voice_id, :comment)
    end
    
    def correct_user
      @comment = Comment.find_by(id: params[:id])
      redirect_to root_url unless @comment.user_id == current_user.id
    end

end
