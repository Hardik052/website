json.extract! product, :id, :product_name, :product_price, :category_id, :product_image,
              :product_color, :product_size, :created_at, :updated_at
json.url product_url(product, format: :json)
