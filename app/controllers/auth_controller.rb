class AuthController < ApplicationController
  skip_before_action :authenticate_request
  
  def auth
    authentication = Authentication.new(params[:email], params[:password])

    if authentication.token
      render json: {token: authentication.token}
    else
      render json: {error: authentication.errors}, status: :unauthorized
    end
  end
end
