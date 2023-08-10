class Order < ApplicationRecord
  attr_accessor :subtotal

  belongs_to :user
  belongs_to :province

  before_create :calculate_taxes

  def calculate_taxes
    self.subtotal = total_price
    self.tax = calculate_tax
    self.total = subtotal + tax
  end

  def calculate_taxes
    tax_rate = province.tax_rate
    self.tax_amount = total_price * (tax_rate.gst_rate + tax_rate.pst_rate + tax_rate.hst_rate)
    self.total_amount = total_price + self.tax_amount
  end

  def total_price
    order_items.sum { |item| item.product.price * item.quantity }
  end
end
