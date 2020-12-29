class TransactionOrder < ApplicationRecord
  has_many :order_products
  has_many :products,through: :order_products
  belongs_to :user
  validates :address,:name,:phone,:postcode,presence: true

end
