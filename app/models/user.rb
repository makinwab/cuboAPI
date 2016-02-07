class User < ActiveRecord::Base
  has_many :buckets, dependent: :destroy
  validates :email, :token, :password, presence: true, length: { minimum: 4 }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: EMAIL_REGEX }
end
