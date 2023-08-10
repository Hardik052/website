class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def new_products
    @products = Product.where("created_at >= ?", 3.days.ago)
  end

  def recently_updated_products
    @products = Product.where("updated_at >= ?", 3.days.ago)
  end

  def index
    @products = Product.all

    if params[:keyword].present?
      @products = @products.where("product_name LIKE ? OR product_description LIKE ?",
                                  "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?

    if params[:filter] == "on_sale"
      @products = @products.where(on_sale: true)
    elsif params[:filter] == "new"
      @products = @products.where("created_at >= ?", 3.days.ago)
    elsif params[:filter] == "recently_updated"
      @products = @products.where("updated_at >= ?", 3.days.ago).where.not("created_at >= ?",
                                                                           3.days.ago)
    end

    @products = @products.page(params[:page]).per(10)  # Display 10 products per page

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

  def edit; end

  def on_sale
    @products = Product.where(on_sale: true)
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html do
          redirect_to product_url(@product), notice: "Product was successfully created."
        end
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
        format.html do
          redirect_to product_url(@product), notice: "Product was successfully updated."
        end
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

  def search
    @products = Product.all

    if params[:keyword].present?
      @products = @products.where("product_name LIKE ? OR product_description LIKE ?",
                                  "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?

    @products = @products.page(params[:page]).per(5)

    render :index
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_name, :product_price, :category_id, :product_image,
                                    :product_color, :product_size, :product_description, :on_sale)
  end

  def add_to_cart
    @product = Product.find(params[:product_id])
    session[:cart] ||= {}
    product_id = @product.id
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1

    redirect_to products_path, notice: "Product added to cart!"
  end

  def product_params
    params.require(:product).permit(:product_name, :product_description, :category_id, :on_sale)
  end
end
