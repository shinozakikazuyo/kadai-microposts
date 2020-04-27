class Relationship < ApplicationRecord
  belongs_to :user
  #User クラスを参照する
  belongs_to :follow, class_name: 'User'
end
