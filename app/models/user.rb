class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts
  #自分がフォローしているUser」への参照 
  has_many :relationships
  #該当の user がフォローしている User 達を取得
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  #自分をフォローしている User 達 を取得
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  
  def follow(other_user)
    #フォローしようとしている other_user が自分自身ではないかを検証
    unless self == other_user
      #フォローしているかを探し、していなければフォロー関係を保存(create = build + save)
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
end
