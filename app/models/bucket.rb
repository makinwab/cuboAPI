class Bucket < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, :user_id, presence: true
  validates_associated :user, :items

  scope(
    :search,
    lambda do |data|
      buckets = where(user_id: data[:id])
      buckets.where("lower(name) like ?", "%#{data[:q]}%") if data[:q]
    end
  )

  scope(
    :paginate,
    lambda do |data|
      paginated_data = get_paginated_data(data)
      offset(paginated_data[:offset]).
          limit(paginated_data[:limit])
    end
  )

  def self.get_paginated_data(params)
    Pagination.new(params[:limit], params[:page]).
      get_pagination_data
  end
end
