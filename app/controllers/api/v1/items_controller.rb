class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.where(bucket_id: params[:bucket_id])

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

  def update
    item = Item.find_by(id: params[:id])
    
    if item.update(items_params)
      render json: item, status: 201
    end
  end

  private

  def items_params
    params.permit(:name, :done)
  end
end
