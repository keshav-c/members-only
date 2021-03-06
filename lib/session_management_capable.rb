# frozen_string_literal: true

# Session management related methods for use in the ApplicationController
module SessionManagementCapable
  def log_in(user)
    token = SecureRandom.urlsafe_base64
    user.update_attribute(:remember_digest, Digest::SHA1.hexdigest(token))
    cookies.permanent[:remember_token] = token
  end

  def log_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def require_login
    return unless current_user.nil?

    flash[:error] = 'You must be logged in before posting'
    redirect_to login_url
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
