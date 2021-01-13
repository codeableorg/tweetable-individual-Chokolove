class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_one_attached :cover

  validates :username, :email, presence: true, uniqueness: true
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
