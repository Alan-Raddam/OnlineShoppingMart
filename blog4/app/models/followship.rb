class Followship < ApplicationRecord
  belongs_to :follower, class_name: "User", foreign_key: "user_id"
  belongs_to :following, class_name: "User", foreign_key: "following_user_id"
  validates :user_id,presence: true
  validates :following_user_id,presence: true
end
