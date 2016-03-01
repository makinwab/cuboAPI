class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.find_by(bucket_id: params[:bucket_id])

    render json: items, status: :ok
  end

  def create
    item = Item.new(items_params)

    if item.save
      render json: item, status: :created
    end
  end

  def show
    item = Item.find_by(id: params[:id], bucket_id: params[:bucket_id])

    render json: item, status: :ok
  end

  private

  def items_params
    params.require(:item).permit(:name, :bucket_id)
  end
end
