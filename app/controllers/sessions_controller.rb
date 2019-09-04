class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      puts "Login successful"
    else
      puts "Login failed"
      render 'new'
    end
  end
end
