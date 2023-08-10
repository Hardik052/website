class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  def remove_product(product_id)
    item = items.find { |item| item["product_id"] == product_id }
    items.delete(item) if item
  end
end
