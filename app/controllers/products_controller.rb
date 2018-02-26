class ProductsController < ApplicationController
  after_action :verify_authorized

  def index
    
    authorize Product
    allProducts = Product.all
    
    #Create two arrays with all the unique brand and material names that are used by the template products/index.html.erb to create html checkboxes
    #The lists are also used by this function to filter products based on query params in the URL
    brands = Array.new
    materials = Array.new
    allProducts.each do |product|
      brands.insert(-1, product.brand)
      materials.insert(-1, product.material)
    end
    @allBrands = brands.uniq
    @allMaterials = materials.uniq
    
    #Create a list of all the products to be displayed by the in html file, after filtering it based on the query params in the URL
    #Params are filtered after "(brandX OR brandY) AND (materialA OR materialB) AND lprice AND hprice" logic
    @products = Array.new
    allProducts.each do |product|
      add = true
      if params[:brand] != nil
        add = false
        brandFilter = paramsToList(params[:brand])
        brandFilter.each do |brandNum|
          if product.brand == @allBrands[brandNum]
            add = true
            break
          end
        end
      end
      if params[:material] != nil && add
        add = false
        materialFilter = paramsToList(params[:material])
        materialFilter.each do |matNum|
          if product.material == @allMaterials[matNum]
            add = true
            break
          end
        end
      end
      if params[:lprice] != nil && priceStringToInt(params[:lprice]) != nil && priceStringToInt(params[:lprice]) > product.price
        add = false
      end 
      if params[:hprice] != nil && priceStringToInt(params[:lprice]) != nil && priceStringToInt(params[:hprice]) < product.price
        add = false
      end
      if add
        @products.insert(-1, product)
      end
    end
    
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
  
  def paramsToList(param_string)
    paramIntList = Array.new
    paramStringList = param_string.split('_')
    paramStringList.each do |ps|
      paramInt = priceStringToInt(ps[1..-1])
      if paramInt != nil
        paramIntList.insert(-1, paramInt)
      end
    end
    paramIntList
  end
  
  def priceStringToInt(param_string)
    num = param_string.to_i
    num if num.to_s == param_string && num >= 0
  end
  
end
