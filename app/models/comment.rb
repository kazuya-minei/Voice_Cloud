class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :voice
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence:true
  validates :voice_id, presence:true
  validates :comment, presence: true, length: { maximum: 140 }
end
