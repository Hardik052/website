class CartsController < ApplicationController
  def show_cart
    @cart_items = cart_items
  end

  def add_to_cart
    product_id = params[:product_id].to_i
    cart_items[product_id] ||= 0
    cart_items[product_id] += 1
    redirect_to show_cart_path
  end

  def update_quantity
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i
    if quantity <= 0
      cart_items.delete(product_id)
    else
      cart_items[product_id] = quantity
    end
    redirect_to show_cart_path
  end

  def remove_from_cart
    product_id = params[:product_id].to_i
    cart_items.delete(product_id)
    redirect_to show_cart_path
  end

  def checkout
    @cart_items = cart_items
    @order = Order.new
  end

  private

  def cart_items
    session[:cart] ||= {}
    session[:cart]
  end
end
