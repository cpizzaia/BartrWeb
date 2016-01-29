require "rails_helper.rb"

describe "Users API" do
  it "sends a user" do
    @user = create(:user)

    get '/api/users/' + @user.id.to_s

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to equal(@user.id)
  end

  it "creates users" do
    @user = build(:user)

    post '/api/users', user: { name: @user.name, password: @user.password, location: @user.location }

    json = JSON.parse(response.body)
    
    expect(response).to be_success
    expect(json["name"]).to eq(@user.name)
    expect(json["id"]).not_to be_nil
    expect(json["location"]).not_to be_nil
  end

end
