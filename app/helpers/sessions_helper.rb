# frozen_string_literal: true

# Helper methods for session handling
module SessionsHelper
  def log_in(token)
    cookies.permanent[:remember_token] = token
  end

  def log_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def digest(token)
    Digest::SHA1.hexdigest(token)
  end

  def current_user
    token = cookies[:remember_token]
    return nil if token.nil?

    @current_user ||= User.find_by(remember_digest: digest(token))
  end

  def current_user=(user)
    @current_user = user
  end

  def require_login
    return unless current_user.nil?

    flash[:error] = 'You must be logged in before posting'
    redirect_to login_url
  end
end
