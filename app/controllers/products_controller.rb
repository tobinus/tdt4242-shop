class ProductsController < ApplicationController
  after_action :verify_authorized

  def index
    authorize Product
    allProducts = Product.all
    @products = Array.new
    allProducts.each do |product|
      #filter product into @products by parameters, this should be moved into its own function
      if params[:brand] == nil || params[:brand] == product.brand
        if params[:material] == nil || params[:material] == product.material
          if params[:lprice] == nil || params[:lprice] <= product.price
            if params[:hprice] == nil || params[:hprice] >= product.price
              @products.insert(-1, product)
            end
          end
        end
      end
    end
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
