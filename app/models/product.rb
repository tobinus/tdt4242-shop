class Product < ApplicationRecord
  validates :name, length: { minimum: 3, maximum: 64 }
end
