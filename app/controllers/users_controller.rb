# frozen_string_literal: true

# Controller for users
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      token = SecureRandom.urlsafe_base64
      log_in(token)
      @user.update_attribute(:remember_digest, Digest::SHA1.hexdigest(token))
      redirect_to root_url
    else
      flash.now[:error] = 'Sign up failed!'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
