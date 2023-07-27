class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :product_image
end
