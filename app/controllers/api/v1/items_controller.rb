module Api
  module V1
    class ItemsController < ApplicationController
      def index
        items = Item.where(bucket_id: params[:bucket_id])
        respond_to_success items, :ok
      end

      def create
        item = Item.new(items_params)
        item.bucket_id = params[:bucket_id]
        if item.save
          respond_to_success item, :created
        end
      end

      def show
        item = Item.find_by(id: params[:id], bucket_id: params[:bucket_id])
        respond_to_success item
      end

      def update
        item = items(params)

        if item.update(items_params)
          respond_to_success item, 201
        else
          respond_to_failure "Could not update item"
        end
      end

      def destroy
        item = items(params)

        if item.destroy
          response = { message: "Item successfully deleted" }
          respond_to_success response, 201
        else
          respond_to_failure "Could not delete item"
        end
      end

      private

      def items_params
        params.permit(:name, :done)
      end

      def items(params)
        Item.find_by(id: params[:id])
      end

      def respond_to_failure(message, status = 501)
        render json: { error: message }, status: status
      end

      def respond_to_success(response, status = :ok)
        render json: response, status: status
      end
    end
  end
end
