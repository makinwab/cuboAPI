class Pagination
  def initialize(limit, page)
    @limit = Integer(limit || 20)
    @page = Integer(page || 1)
  end

  def get_pagination_data
    {
      limit: @limit,
      offset: @limit * (@page - 1)
    }
  end
end
