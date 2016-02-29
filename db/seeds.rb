# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@user = User.create(username: "bartr", password: "123456", location: "somewhere")

10.times do
  @user.items.create({
  name: "An Item",
  description: "This is the items description.",
  image: File.new("#{Rails.root}/app/assets/images/item_missing.png")
  })
end
