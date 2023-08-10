class Product < ApplicationRecord
  has_many :cart_items

  belongs_to :category
  has_one_attached :product_image

  scope :new_products, -> { where("created_at >= ?", 3.days.ago) }
  scope :recently_updated_products, -> { where("updated_at >= ?", 3.days.ago) }

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "id", "on_sale", "product_color", "product_description", "product_image", "product_name", "product_price", "product_size", "updated_at"]
  end
  validates :product_name,presence: true

  validates :product_price,  numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
