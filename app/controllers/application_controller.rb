class ApplicationController < ActionController::Base
  include SessionManagementCapable
  helper_method :current_user
end
