class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all

    case params[:filter]
    when 'on_sale'
      @products = @products.where(on_sale: true)
    when 'new'
      @products = @products.where('created_at >= ?', 3.days.ago)
    when 'recently_updated'
      @products = @products.where('updated_at >= ?', 3.days.ago).where.not('created_at >= ?', 3.days.ago)
    end

    @products = @products.page(params[:page]).per(5)  # Display 5 products per page

    respond_to do |format|
      format.html  # index.html.erb
      format.json { render json: @products }
    end
  end

  def show
    @categories = Category.includes(:products).all
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_name, :product_price, :category_id, :product_image, :product_color, :product_size)
  end
end
