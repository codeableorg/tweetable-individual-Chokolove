class Tweet < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :body, presence: true
  validates :body, length: { maximum: 140 } 
  before_create do
    self.comments_count = 0
  end
  belongs_to :user
end
