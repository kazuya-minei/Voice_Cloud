class VoiceLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  before_action :voice_params

  def create
    VoiceLike.create(user_id: current_user.id, voice_id: params[:id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    VoiceLike.find_by(user_id: current_user.id, voice_id: params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

    def voice_params
      @voice = Voice.find(params[:id])
    end

    def correct_user
      @voicelike = current_user.voiceLikes.find_by(voice_id: params[:id])
      redirect_to root_url unless @voicelike.user_id == current_user.id
    end

end
