class User < ActiveRecord::Base
  has_many :buckets, dependent: :destroy

  validates :email, :password, presence: true, length: { minimum: 4 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: EMAIL_REGEX }

  def generate_token
    payload = { user_id: id }
    AuthToken.encode payload
  end
end
