require "rails_helper.rb"

RSpec.describe User, type: :model do
  describe ".find_by_credentials" do
    it "returns the correct user given an email and password" do
      @user = create(:user)
      result = User.find_by_credentials(@user.username, @user.password)
      expect(result).to eq(@user)
    end
  end

  describe "#password=" do
    before(:each) do
      @user = build(:user)
      @user.password=("password")
    end

    it "sets the instance variable @password" do
      expect(@user.password).to eq("password")
    end

    it "sets an attribute password_digest" do
      expect(@user.password_digest).to_not be_nil
    end

    it "password_digest and password are not the same" do
      expect(@user.password).not_to eq(@user.password_digest)
    end
  end

  describe "#is_password?" do
    before(:each) do
      @user = build(:user)
      @user.password=("password")
    end

    it "returns true if the password is correct" do
      expect(@user.is_password?("password")).to be true
    end

    it "returns false if the password is incorrect" do
      expect(@user.is_password?("password1")).to be false
    end

    it "returns false when given nil" do
      expect(@user.is_password?(nil)).to be false
    end
  end

  describe "#generate_session_token" do
    before(:each) do
      @user = build(:user)
    end

    it "sets the session_token of the user after initialize" do
      expect(@user.session_token).not_to be_nil
    end

    it "does not generate another session_token if one already exists" do
      token = @user.session_token
      @user.generate_session_token
      expect(@user.session_token).to eq(token)
    end
  end

  describe "#reset_session_token" do
    before(:each) do
      @user = build(:user)
    end

    it "changes the session_token" do
      old_token = @user.session_token
      @user.reset_session_token
      expect(@user.session_token).not_to eq(old_token)
    end

    it "returns the new session token" do
      token = @user.reset_session_token
      expect(@user.session_token).to eq(token)
    end

    it "persists changes to the database" do
      expect(@user).to receive(:save)
      @user.reset_session_token
    end
  end

  describe "#items" do
    before(:each) do
      @user = create(:user)
      @item = @user.items.create(attributes_for(:item))
    end

    it "returns the items the user has" do
      expect(@user.items.first).to eq(@item)
    end

    it "should have many items" do
      t = User.reflect_on_association(:items)
      expect(t.macro).to eq(:has_many)
    end
  end
end
