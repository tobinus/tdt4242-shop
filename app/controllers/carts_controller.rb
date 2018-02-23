class CartsController < ApplicationController
  def new
    authorize Cart
    @cart = Cart.new
  end

  def index
    authorize Cart
  end

  def create
    authorize Cart
    # create a new cart
    @cart = Cart.new

    # add the user's ID to the new cart
    @cart.user_id = params['user_id']

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    authorize Cart
    @cart = Cart.find_by(user_id: current_user.id)
  end
end
