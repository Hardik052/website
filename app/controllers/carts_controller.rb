class CartsController < ApplicationController
  GST = 5

  State_tax = {

    "Alberta"                   => 0,

    "British Columbia"          => 7,

    "Manitoba"                  => 7,

    "New Brunswick"             => 10,

    "Newfoundland and Labrador" => 10,

    "Northwest Territories"     => 0,

    "Nova Scotia"               => 10,

    "Nunavut"                   => 0,

    "Ontario"                   => 8,

    "Prince Edward Island"      => 10,

    "Quebec"                    => 9.975,

    "Saskatchewan"              => 6,

    "Yukon"                     => 0

  }

  def update_cart_address
    @address = params[:address]

    @postal_code = params[:postal_code]

    @province = params[:province]



    session[:address] = @address

    session[:postal_code] = @postal_code

    session[:province] = @province




    redirect_to root_path
  end

  def show_cart
    @cart_items = cart_items
  end

  def add_to_cart
    product_id = params[:product_id].to_i
    cart_items[product_id] ||= 0
    cart_items[product_id] += 1
    puts "Cart after adding item: #{session[:cart]}"
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
    session[:cart] = cart_items
    puts "Updated cart items: #{cart_items}"

    redirect_to show_cart_path
  end

  def checkout
    @cart_items = cart_items
    @cart_contents = session[:cart] || {}

    @address = session[:address]

    @postal_code = session[:postal_code]

    @province = session[:province]

    # Call the method on the order instance
  end

  private

  def calculate_totals
    @order.total_price = 0
    @cart_items.each do |product_id, quantity|
      product = Product.find(product_id)
      @order.total_price += product.product_price * quantity
    end
  end

  def cart_items
    session[:cart] ||= {}
    session[:cart]
  end

  def process_checkout
    @cart_items = cart_items
    @order = current_user.orders.build(order_params)
    @order.calculate_taxes

    if @order.save
      @cart_items.each do |product_id, quantity|
        # Deduct quantity from product inventory
        product = Product.find(product_id)
        product.update(inventory: product.inventory - quantity)
      end

      session[:cart] = {} # Clear the cart
      redirect_to order_confirmation_path(@order)
    else
      render :checkout
    end
  end

  def order_params
    params.require(:order).permit(:address, :province)
  end

  def check_out
    @cart_contents = session[:cart] || {}

    @address = session[:address]

    @postal_code = session[:postal_code]

    @province = session[:province]
  end

  def checkout_params
    params.require(:checkout).permit(:address, :postal_code, :province)
  end
end
