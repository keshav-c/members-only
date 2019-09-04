module SessionsHelper
  def log_in(user)
    token = SecureRandom.urlsafe_base64
    cookies.permanent[:remember_token] = token
    user.update_attribute(:remember_digest, digest(token))
  end

  def digest(token)
    Digest::SHA1.hexdigest(token)
  end

  def current_user
    token = cookies[:remember_token]
    return nil if token.nil?
    @current_user ||= User.find_by(remember_digest: digest(token))
  end

  def log_out
    cookies.delete(:remember_token)
    @current_user = nil
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in before posting"
      redirect_to login_url
    end
  end
end
