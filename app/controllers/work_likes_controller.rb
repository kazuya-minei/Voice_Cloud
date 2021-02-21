class WorkLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  before_action :work_params

  def create
    WorkLike.create(user_id: current_user.id, work_id: params[:id])
  end

  def destroy
    WorkLike.find_by(user_id: current_user.id, work_id: params[:id]).destroy
  end

  private

  #投稿のidを取得
    def work_params
      @work = Work.find(params[:id])
    end

    def correct_user
      @worklike = current_user.workLikes.find_by(work_id: params[:id])
      redirect_to root_url unless @worklike.user_id == current_user.id
    end

end
