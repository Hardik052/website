class CreateTaxRates < ActiveRecord::Migration[7.0]
  def change
    create_table :tax_rates do |t|
      t.string :province
      t.float :gst
      t.float :pst
      t.float :hst

      t.timestamps
    end
  end
end
