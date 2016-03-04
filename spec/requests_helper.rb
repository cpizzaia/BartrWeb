module RequestsHelper

  def login(user)
    post '/api/session', user: { username: user.username, password: user.password }
  end

  def logout
    delete '/api/session'
  end

  def fetch_current_user(session_token)
    get 'api/session', nil, {authorization: session_token}
  end

end

RSpec.configure do |config|
  config.include RequestsHelper, type: :request
end
