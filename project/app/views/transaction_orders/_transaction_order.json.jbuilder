json.extract! transaction_order, :id, :sum, :address, :name, :phone, :postcode, :sstatus, :created_at, :updated_at
json.url transaction_order_url(transaction_order, format: :json)
