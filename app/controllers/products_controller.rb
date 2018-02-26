class ProductsController < ApplicationController
  after_action :verify_authorized

  def index
    authorize Product
    @products = Product.all
  end

  def manage
    authorize Product
    @products = Product.all
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
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
        format.js   { render :new, content_type: 'text/javascript' }
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
