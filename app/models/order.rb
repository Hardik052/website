class Order < ApplicationRecord
  attr_accessor :subtotal

  belongs_to :user

  before_create :calculate_taxes

  private

  def calculate_taxes
    tax_rate = TaxRate.find_by(province:)
    self.gst_amount = (total_price * tax_rate.gst) / 100
    self.pst_amount = (total_price * tax_rate.pst) / 100
    self.hst_amount = (total_price * tax_rate.hst) / 100
    self.total_amount = total_price + gst_amount + pst_amount + hst_amount
  end
end
