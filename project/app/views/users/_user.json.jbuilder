json.extract! user, :id, :name, :password, :isadmin, :email, :phone, :created_at, :updated_at
json.url user_url(user, format: :json)
