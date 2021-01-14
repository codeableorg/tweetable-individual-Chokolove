class Comment < ApplicationRecord
  belongs_to :tweet, counter_cache: true
  belongs_to :user
  validates :body, presence: true
  validates :body, length: { maximum: 140 } 
end
