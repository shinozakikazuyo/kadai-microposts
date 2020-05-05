class User < ApplicationRecord
  
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  #一対多（テーブル名）
  has_many :microposts #ユーザーに対してのPOST
  has_many :relationships #ユーザーに対してのフォロワー
  has_many :favorites #ユーザーに対してのお気に入り
  
  
  #該当の user がフォローしている User 達を取得
  has_many :followings, through: :relationships, source: :follow
  #自分をフォローしている User 達 を取得
  #参照するクラスを指定
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  #お気に入り登録
  has_many :likes, through: :favorites, source: :micropost
  
  
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
  
  
  #お気に入り機能
  def favorite(micropost)
    #登録済みかをチェックする
    favorites.find_or_create_by(micropost_id: micropost.id)
  end

  def unfavorite(micropost)
    favorite = favorites.find_by(micropost_id: micropost.id)
    favorite.destroy if favorite
  end
  
  def favorite?(micropost)
    self.likes.include?(micropost)
  end
  
end