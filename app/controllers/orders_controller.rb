class OrdersController < ApplicationController
  def new
    authorize Order
    @order = Order.new
  end

  def checkout
    authorize Order
    @order = Order.new
    @cart = Cart.find_by(user_id: current_user.id)
    @total_amount = calculate_total_amount
  end

  def create
    authorize Order
    logger.debug order_params
    @order = Order.new
    @order.user_id = order_params[:user_id]
    @order.credit_card_type = order_params[:credit_card_type]
    @order.credit_card_name = order_params[:credit_card_name]
    @order.credit_card_number = order_params[:credit_card_number]
    @order.credit_card_cvc = order_params[:credit_card_cvc]
    logger.debug order_params[:credit_card_expiry_year].inspect
    logger.debug order_params[:credit_card_expiry_month].inspect
    @order.credit_card_expiry = Date.new(order_params[:credit_card_expiry_year].to_i, order_params[:credit_card_expiry_month].to_i, 1)

    # get the contents of the cart
    @cart = Cart.find(current_user.cart_id)

    # for security reasons, calculate the total amount from the actual cart (instead of taking a parameter)
    @order.total_amount = calculate_total_amount
    @order.save

    # create an order_item out of all cart_items
    # then remove order items
    @cart.cart_items.each do |cart_item|
      @order_item = OrderItem.create(order_id: @order.id, product_id: cart_item.product_id, amount: cart_item.amount)
      CartItem.find(cart_item.id).destroy
    end

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'The order has been placed.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    authorize Order
    @orders = Order.where(user_id: current_user.id)
  end

  def index_all
    authorize Order
    @orders = Order.all
  end

  def show
    authorize Order
    @order = Order.find(params[:id])
  end

  private

  # Only allow the whitelisted parameters.
  def order_params
    params.require(:order).permit(:user_id, :credit_card_type, :credit_card_name, :credit_card_number,
                                  :credit_card_expiry_month, :credit_card_expiry_year, :credit_card_cvc
    )
  end

  def calculate_total_amount
    cart = Cart.find_by(user_id: current_user.id)
    total_amount = 0
    cart.cart_items.each do |cart_item|
      logger.debug cart_item.inspect
      total_amount += cart_item.amount * cart_item.product.price
    end
    total_amount
  end
end
