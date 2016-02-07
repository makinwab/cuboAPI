class Bucket < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: true
  validates :name, presence: true
end
