class Authentication
  attr_reader :errors

  def initialize(email, password)
    @email = email
    @password = password
    @errors = {}
  end

  def token
    @token ||= JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(email)
    return user if user&.authenticate(password)

    @errors[:user] = 'invalid credentials'
    nil
  end
end