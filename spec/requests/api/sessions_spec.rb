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
      expect(@user.username).to eq(current_user.username)
      expect(json["id"]).to equal(@user.id)
    end

    it "logs a user out" do
      login(@user)
      logout

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(current_user).to be_nil
    end
  end
end
