# frozen_string_literal: true

# Helper methods for session handling
module SessionsHelper
  def logged_in?
    !current_user.nil?
  end

  def current_user
    token = cookies[:remember_token]
    return nil if token.nil?

    @current_user ||= User.find_by(remember_digest: Digest::SHA1.hexdigest(token))
  end

  def current_user=(user)
    @current_user = user
  end
end
