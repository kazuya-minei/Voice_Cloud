class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :works, dependent: :destroy
  has_many :voices, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :workLikes, dependent: :destroy
  has_many :active_relationships,  class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                    dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                    dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  attr_accessor :remember_token
  before_save { email.downcase! }
  validates :name, presence: true,
             length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
             length: { maximum: 255 },
             format: { with: VALID_EMAIL_REGEX },
             uniqueness: true
  
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :introduction_text, length: {maximum: 150}
  
  
  
  def User.digest(string) #fixture向け、ハッシュ化メソッド
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end

    # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def liked_by?(work_id)
    workLikes.where(work_id: work_id).exists?
  end  
  
  mount_uploader :avatar, AvatarUploader
  mount_uploader :voice_s, VoiceSampleUploader
end
