module RequestsHelper
  def current_user
    User.find_by_session_token(session[:session_token])
  end
end

RSpec.configure do |config|
  config.include RequestsHelper, type: :request
end
