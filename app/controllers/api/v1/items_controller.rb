class Api::V1::ItemsController < ApplicationController
  def index
    render json: Item.all, status: :ok
  end

  def create
    item = Item.new(items_params)

    if item.save
      render json: item, status: :created
    end
  end

  private
    def items_params
      params.require(:item).permit(:name, :bucket_id)
    end
end
