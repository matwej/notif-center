class AuthRequest
  attr_reader :errors
  
  def initialize(headers = {})
    @headers = headers
    @errors = {}
  end

  def user
    @user ||= User.find(decoded_token[:user_id]) if decoded_token
  end

  private

  attr_reader :headers

  def decoded_token
    @decoded_token = JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      @errors[:token] = "Missing or malformed auth header"
    end
    nil
  end
end