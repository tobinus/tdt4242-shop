class Product < ApplicationRecord
  validates :name, length: { minimum: 3, maximum: 64 }
  validates :description, length: { minimum: 3, maximum: 1024 }
  validates :stock_level, numericality: { only_integer: true }
  validates :price, numericality: true
  validates :brand, presence: true
  validates :material, presence: true
  validates :weight, numericality: true
end
