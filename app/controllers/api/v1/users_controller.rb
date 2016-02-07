class Api::V1::UsersController < ApplicationController
  def index
    render json: User.all, status: :ok
  end
end
