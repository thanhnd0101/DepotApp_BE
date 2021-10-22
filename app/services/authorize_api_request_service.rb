class AuthorizeApiRequestService < ApplicationService

  def initialize(headers)
    super
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(@decoded_auth_token["user_id"]) if decoded_auth_token
    @user || Rails.logger.error("Invalid token - #{__FILE__ }#{__LINE__ }") && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    @decoded_auth_token if @decoded_auth_token.present?
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      Rails.logger.error("Missing token - #{__FILE__ }#{__LINE__ }")
    end
    nil
  end
end