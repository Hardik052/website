class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)

    if @order.save
      flash[:notice] = "Order placed successfully."
      session[:cart] = [] # Clear the cart after successful order
      redirect_to root_path
    else
      render "carts/checkout"
    end
  end

  private

  def order_params
    params.require(:order).permit(:province)
  end
end
