class ApplicationController < ActionController::API
  before_action :authenticate_user_from_token, :add_allow_credentials_header

  def add_allow_credentials_header
    response.headers["Access-Control-Allow-Origin"] =
      request.headers["Origin"] || "*"

    response.headers["Access-Control-Allow-Credentials"] = "true"
  end

  def authenticate_user_from_token

    if claims && user = User.find_by(id: claims[:user_id])
      @current_user = user
    else
      render json: { errors: { unauthorized: "You are not authorized to perform this action." } },
             status: 401
    end
  end

  def claims
    AuthToken.decode get_token
  end

  def get_token
    if request.headers["Authorization"].present?
      request.headers["Authorization"].split(" ").last
    end
  rescue
    nil
  end
end
