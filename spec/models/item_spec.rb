require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "#owner" do

    it "should belong to a user" do
      @user = create(:user)
      @item = @user.items.create(attributes_for(:item))
      expect(@item.owner).to eq(@user)
    end

    it "should be a belongs_to relationship" do
      t = Item.reflect_on_association(:owner)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
