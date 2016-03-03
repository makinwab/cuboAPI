class Api::V1::BucketsController < ApplicationController
  def index
    buckets = Bucket.where(user_id: @current_user.id)
    render json: buckets, status: :ok
  end

  def create
    bucketlist = Bucket.new(buckets_params)
    bucketlist.user_id = @current_user.id

    if bucketlist.save
      render json: bucketlist, status: :created
    end
  end

  def show
    bucketlist = Bucket.find_by(id: params[:id])

    render json: bucketlist, status: :ok
  end

  private

  def buckets_params
    params.permit(:name)
  end
end
