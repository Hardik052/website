# db/seeds.rb

require 'faker'

# Delete existing data
Product.delete_all
Category.delete_all

# Seed categories
categories = %w[Ball Bat Jersey IPL]
categories.each { |category| Category.create(name: category) }

# Seed products with placeholder image URLs from Faker::LoremFlickr
categories.each do |category|
  10.times do
    product = Product.create(
      product_name: Faker::Commerce.product_name,
      product_price: Faker::Commerce.price(range: 10..100),
      category: Category.find_by(name: category),
      product_color: Faker::Commerce.color,
      product_size: Faker::Commerce.material,
    )
  end
end
