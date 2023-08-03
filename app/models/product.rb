class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :product_image

  scope :new_products, -> { where("created_at >= ?", 3.days.ago) }
  scope :recently_updated_products, -> { where("updated_at >= ?", 3.days.ago) }
end
