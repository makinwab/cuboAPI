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
    else
      render json: { error: "Could not create bucket" }, status: 500
    end
  end

  def show
    bucketlist = Bucket.find_by(id: params[:id])

    render json: bucketlist, status: :ok
  end

  def update
    bucket = Bucket.find_by(id: params[:id])

    if bucket.update(buckets_params)
      render json: bucket, status: 201
    else
      render json: { error: "Could not update bucket" }, status: 500
    end
  end

  def destroy
    bucket = Bucket.find_by(id: params[:id])

    if bucket.destroy
      render json: { message: "Bucketlist successfully deleted" }, status: 201
    else
      render json: { error: "Could not delete bucket" }, status: 500
    end
  end

  private

  def buckets_params
    params.permit(:name)
  end
end
