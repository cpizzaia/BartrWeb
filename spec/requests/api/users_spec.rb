require "rails_helper.rb"

RSpec.describe Api::UsersController, type: :request do
  describe "Users API" do
    it "sends a user" do
      @user = create(:user)

      get '/api/users/' + @user.id.to_s

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["id"]).to equal(@user.id)
    end

    it "creates users and logs them in" do
      @user = build(:user)

      post '/api/users', user: { name: @user.name, password: @user.password, location: @user.location }

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["name"]).to eq(current_user.name)
      expect(json["name"]).to eq(@user.name)
      expect(json["id"]).not_to be_nil
      expect(json["location"]).not_to be_nil
    end

    it "updates a user" do
      @user = create(:user)
      login(@user)
      @user.location = "test1"

      patch '/api/users/' + @user.id.to_s, user: { location: @user.location }

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["location"]).to eq(@user.location)
    end
  end
end
