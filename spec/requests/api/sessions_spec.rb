require "rails_helper.rb"

RSpec.describe Api::SessionsController, type: :request do

  before(:each) do
    @user = create(:user)
  end

  describe "Session API" do
    it "logs a user in" do
      login(@user)

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["id"]).to equal(@user.id)
    end

    it "logs a user out" do
      login(@user)
      logout

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(current_user).to be_nil
    end

    it "returns the current user" do
      login(@user)

      json = JSON.parse(response.body)

      fetch_current_user(json["session_token"])

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["id"]).to eq(@user.id)
    end
  end
end
