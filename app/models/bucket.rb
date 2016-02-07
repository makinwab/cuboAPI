class Bucket < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, :user_id, presence: true
  validates_associated :user, :items
end
