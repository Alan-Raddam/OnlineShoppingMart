json.extract! transaction_item, :id, :quantity, :price, :created_at, :updated_at
json.url transaction_item_url(transaction_item, format: :json)
