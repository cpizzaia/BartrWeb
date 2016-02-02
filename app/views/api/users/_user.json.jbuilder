json.extract!(user, :id, :username, :location, :session_token)

json.image_url asset_path(user.image.url)
