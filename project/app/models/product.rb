class Product < ApplicationRecord
  require 'carrierwave/orm/activerecord'
  has_many :order_products,dependent: :destroy
  has_many :transaction_order,through: :order_products
  belongs_to :product_type
  validates_presence_of [:name,:price,:description,:product_type_id]
  has_many :favorites,dependent: :destroy
  has_many :users,through: :favorites
  mount_uploaders :pics,ProductpicUploader
  serialize :pics,JSON
  belongs_to :color
  has_many :cartitems,dependent: :destroy

end
