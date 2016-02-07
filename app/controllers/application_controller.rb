class ApplicationController < ActionController::API
  before_action :add_allow_credentials_header

  def add_allow_credentials_header
    response.headers["Access-Control-Allow-Origin"] = request.headers['Origin'] || "*"
    response.headers["Access-Control-Allow-Credentials"] = "true"
  end
end
