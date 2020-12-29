json.extract! cartitem, :id, :quantity, :created_at, :updated_at
json.url cartitem_url(cartitem, format: :json)
