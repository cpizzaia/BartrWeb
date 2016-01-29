require "rails_helper.rb"

RSpec.describe Api::ItemsController, type: :request do

  before(:each) do
    @user = create(:user)
  end

  describe "Items API" do
    it "allows users to see an item" do
      @item = @user.items.create(attributes_for(:item))

      get "/api/items/" + @item.id.to_s

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["name"]).to eq(@item.name)
    end

    it "allows users create an item" do
      login(@user)
      @item = attributes_for(:item)
      post '/api/items', item: @item

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["name"]).to eq(@item[:name])
      expect(@user.items.count).to eq(1)
    end

    it "allows users to update their items" do
      @item = @user.items.create(attributes_for(:item))
      login(@user)

      patch '/api/items/' + @item.id.to_s, item: { name: "test2" }

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["name"]).to eq("test2")
    end

    it "allows users to delete their items" do
      @item = @user.items.create(attributes_for(:item))
      login(@user)



      delete '/api/items/' + @item.id.to_s

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(@user.items.count).to eq(0)
    end
  end
end
