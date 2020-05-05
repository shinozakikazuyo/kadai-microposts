class Favorite < ApplicationRecord
  # belongs_to :user, class_name: "User", foreign_key: :user_id
  belongs_to :user
  # belongs_to :micropost, class_name: 'Micropost', foreign_key: :micropost_id
   belongs_to :micropost
end

