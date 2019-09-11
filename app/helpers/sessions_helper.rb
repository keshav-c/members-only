# frozen_string_literal: true

# Helper methods for session handling
module SessionsHelper
  def logged_in?
    !current_user.nil?
  end
end
