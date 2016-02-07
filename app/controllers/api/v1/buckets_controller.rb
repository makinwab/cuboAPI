class Api::V1::BucketsController < ApplicationController
  def index
    render json: Bucket.all, status: :ok
  end

  def create
    bucketlist = Bucket.new(buckets_params)

    if bucketlist.save
      render json: bucketlist, status: :created
    end
  end

  private
    def buckets_params
      params.require(:bucket).permit(:name, :user_id)
    end
end
