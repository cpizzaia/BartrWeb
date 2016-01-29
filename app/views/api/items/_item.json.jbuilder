json.extract!(item, :id, :name, :description)

json.image_url asset_path(item.image.url)
