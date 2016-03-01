class Api::V1::UsersController < ApplicationController
  def index
    render json: User.all, status: :ok
  end

  def create
    user = User.new(users_params)

    if user.save
      render json: user, status: :created
    end
  end

  private

  def users_params
    params.require(:user).permit(:email, :password, :token)
  end
end
