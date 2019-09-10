# frozen_string_literal: true

# Controller class for sessions
class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      token = SecureRandom.urlsafe_base64
      log_in(token)
      user.update_attribute(:remember_digest, Digest::SHA1.hexdigest(token))
      redirect_to root_url
    else
      flash.now[:danger] = 'Invalid credentials.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
