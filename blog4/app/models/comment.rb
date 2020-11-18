class Comment < ApplicationRecord
  belongs_to :blog
  belongs_to :user
  validates :blog_id,presence: true
  validates :user_id,presence: true
  validates :content,presence: true
end
