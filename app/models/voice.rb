#  "user_id", null: false
#  "work_id", null: false
#  "voice_data"
#  "created_at", precision: 6, null: false
#  "updated_at", precision: 6, null: false
#
class Voice < ApplicationRecord
  belongs_to :user
  belongs_to :work
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence:true
  validates :work_id, presence:true
  validates :voice_data, presence:true
  mount_uploader :voice_data, WorkVoiceDataUploader
end
