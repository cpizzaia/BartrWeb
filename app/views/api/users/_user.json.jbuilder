json.extract!(user, :id, :name, :location)

json.image_url asset_path(user.image.url)
