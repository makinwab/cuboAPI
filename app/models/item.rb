class Item < ActiveRecord::Base
  belongs_to :bucket
  validates :name, :bucket_id, presence: true
end
