class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def current_user
    User.find_by_session_token(auth_token)
  end

  def auth_token
    request.authorization
  end

  def login(user)
    user.reset_session_token
  end

  def logout
    current_user.reset_session_token
  end
end
