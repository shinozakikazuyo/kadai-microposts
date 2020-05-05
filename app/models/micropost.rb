class Micropost < ApplicationRecord
  
  #ユーザの紐付け無しには Micropost を保存できない
  belongs_to :user
  validates :content, presence: true, length: { maximum: 255 }
  
  #一対多
  has_many :users
  
end
