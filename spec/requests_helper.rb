module RequestsHelper
  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def login(user)
    post '/api/session', user: { username: user.username, password: user.password }
  end

  def logout
    delete '/api/session'
  end
end

RSpec.configure do |config|
  config.include RequestsHelper, type: :request
end
