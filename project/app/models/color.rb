class Color < ApplicationRecord
  has_many :products,dependent: :nullify
end
