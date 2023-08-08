
class CartsController < ApplicationController
  def show_cart
    @cart_items = session[:cart] || {} # Retrieve cart items from session
  end

  def add_to_cart
    product_id = params[:product_id].to_i
    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1
    redirect_to products_path, notice: 'Product added to cart.'
  end
  def update_quantity
    product_id = params[:product_id].to_i
    new_quantity = params[:quantity].to_i
    session[:cart][product_id] = new_quantity

    redirect_to show_cart_carts_path
  end

  def remove_from_cart
    product_id = params[:product_id].to_i
    session[:cart].delete(product_id)

    redirect_to show_cart_carts_path
  end
end
