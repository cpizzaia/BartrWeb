json.extract!(user, :id, :username, :location)

json.image_url asset_path(user.image.url)
