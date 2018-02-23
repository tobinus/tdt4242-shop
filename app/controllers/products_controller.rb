class ProductsController < ApplicationController
  after_action :verify_authorized

  def index
    authorize Product
    @products = Product.all
  end

  def manage
    authorize Product
    @product = Product.new
  end

  def show
    authorize Product
    @product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    authorize Product
    @product = Product.new
  end

  def edit
    authorize Product
  end

  # POST /products
  def create
    authorize Product
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'The product has been created successfully.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize Product
  end

  def destroy
    authorize Product
  end

  private

  # Only allow the whitelisted parameters.
  def product_params
    params.require(:product).permit(:name, :description, :stock_level, :price, :brand, :material, :weight)
  end
end
