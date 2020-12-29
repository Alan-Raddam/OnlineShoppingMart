json.extract! product, :id, :name, :price, :favorites, :sales, :description, :image_directory, :gender, :created_at, :updated_at
json.url product_url(product, format: :json)
