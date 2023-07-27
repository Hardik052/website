class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.decimal :product_price
      t.references :category, null: false, foreign_key: true
      t.string :product_image
      t.string :product_color
      t.string :product_size

      t.timestamps
    end
  end
end
