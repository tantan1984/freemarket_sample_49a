class ApplicationController < ActionController::Base
  before_action :basic_auth
  protect_from_forgery with: :exception
  require 'payjp'
  Payjp.api_key=Rails.application.credentials.payjp_secret_key

  private
  
  def basic_auth
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
      end
    end
  end
end
