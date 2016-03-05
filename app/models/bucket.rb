class Bucket < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, :user_id, presence: true
  validates_associated :user, :items

  scope(
    :search,
    lambda do |data|
      buckets = where(user_id: data[:id])
      buckets.where("lower(name) like ?", "%#{data[:q]}%") unless data[:q].nil?
    end
  )

  scope(
    :paginate,
    lambda do |data|
      paginated_data = get_paginated_data(data)
      where(user_id: data[:id]).
        offset(paginated_data[:offset]).
          limit(paginated_data[:limit])
    end
  )

  def self.get_paginated_data(params)
    Pagination.new(params[:limit], params[:page]).
      get_pagination_data
  end
end
