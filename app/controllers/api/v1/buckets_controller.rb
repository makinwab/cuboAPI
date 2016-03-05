class Api::V1::BucketsController < ApplicationController
  def index
    params[:id] = @current_user.id

    buckets = Bucket.search(params).paginate(params)
    render json: buckets, status: :ok
  end

  def create
    bucketlist = Bucket.new(buckets_params)
    bucketlist.user_id = @current_user.id

    if bucketlist.save
      render json: bucketlist, status: :created
    else
      render json: { error: "Could not create bucket" }, status: 501
    end
  end

  def show
    bucketlist = bucketlist(params)

    render json: bucketlist, status: :ok
  end

  def update
    bucket = Bucket.find_by(id: params[:id])

    if bucket.update(buckets_params)
      render json: bucket, status: 201
    else
      render json: { error: "Could not update bucket" }, status: 501
    end
  end

  def destroy
    bucketlist = bucketlist(params)

    if bucketlist.destroy
      render json: { message: "Bucketlist successfully deleted" }, status: 201
    else
      render json: { error: "Could not delete bucket" }, status: 501
    end
  end

  private

  def buckets_params
    params.permit(:name)
  end

  def bucketlist(params)
    Bucket.find_by(id: params[:id])
  end
end
