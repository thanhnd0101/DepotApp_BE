class AuthenticationUserService < ApplicationService

  def initialize(name, password)
    super
    @name = name
    @password = password
  end

  def call
    @token = JsonWebToken.encode(user_id: user.id) if user
    if @token.present?
      return {
        auth_token: @token,
        user_id: user.id
      }
    end
    nil
  end

  private

  attr_reader :password, :name

  def user
    @user ||= User.find_by(name: name)
    return @user if @user.try(:authenticate, password)

    nil
  end

end