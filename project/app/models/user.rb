class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cartitems
  has_many :transaction_orders
  has_many :transaction_items
  has_many :favorites
  has_many :products,through: :favorites
end
