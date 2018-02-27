class OrdersController < ApplicationController
  def new
    authorize Order
    @order = Order.new
  end

  def checkout
    authorize Order
    @order = Order.new
    @cart = Cart.find_by(user_id: current_user.id)
    @total_amount, @total_discount, @discounts = calculate_total_amount
  end

  def create
    authorize Order
    @order = Order.new
    # we have to explicitly read and save every parameter because the expiry month/year are coming in as
    # separate parameters but should be unified in one field before saving to the database
    @order.user_id = order_params[:user_id]
    @order.credit_card_type = order_params[:credit_card_type]
    @order.credit_card_name = order_params[:credit_card_name]
    @order.credit_card_number = order_params[:credit_card_number].gsub(/\s+/, "")
    @order.credit_card_cvc = order_params[:credit_card_cvc]
    @order.credit_card_expiry = Date.new(
        order_params[:credit_card_expiry_year].to_i,
        order_params[:credit_card_expiry_month].to_i, 1
    )

    # get the contents of the cart
    @cart = Cart.find(current_user.cart_id)

    # for security reasons, calculate the total amount from the actual cart (instead of taking a parameter)
    @total_amount, @total_discount, @discounts = calculate_total_amount
    @order.total_amount = @total_discount

    # before creating anything, check if there is enough stock of all requested products
    # in case there is a problematic item, it will be saved to @cart_item
    @cart_item = nil
    @cart.cart_items.each do |cart_item|
      if cart_item.product.stock_level < cart_item.amount
        @cart_item = cart_item
      end
    end

    respond_to do |format|
      if @order.save and @cart_item.nil?
        # create order_items out of all cart_items
        # decrease stock level of all cart_items by amount ordered
        # then remove order items
        @cart.cart_items.each do |cart_item|
          #@order_item = OrderItem.create(order_id: @order.id, product_id: cart_item.product_id, amount: cart_item.amount)
          cart_item.becomes!(OrderItem)
          cart_item.update!(cart_item.id, order_id: @order.id, cart_id: nil)
          cart_item.product.stock_level -= 1
          cart_item.product.save!
        end

        format.html { redirect_to @order, notice: 'Your order has been placed.' }
        format.json { render :show, status: :created, location: @order }
      else
        unless @cart_item.nil?
          @order.errors.add(:base, "We do not have enough items of #{@cart_item.product.name} left: #{@cart_item.amount} requested, #{@cart_item.product.stock_level} in stock.")
        end
        format.html { render :checkout }
        format.json { render json: @order.errors, status: :unprocessable_entity }
        format.js   { render :checkout, content_type: 'text/javascript' }
      end
    end
  end

  def index
    authorize Order
    @orders = Order.where(user_id: current_user.id)
  end

  def manage
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
    # retrieve base data
    cart = Cart.find_by(user_id: current_user.id)
    deals = Deal.all.includes(:product)

    # return elements
    total_amount = 0
    discount_amount = 0
    discounts = Array.new

    # calculation
    cart.cart_items.each do |cart_item|
      # calculate initial total amount (without deals)
      total_amount += cart_item.amount * cart_item.product.price

      # check all deals for this product
      deals.each do |deal|
        if deal.product_id == cart_item.product_id
          # check for volume-based deals and if trigger amount is reached
          multiplier = 0
          if deal.type == 'VolumeDeal'
            logger.debug "Trigger amount is #{deal.deal_amount} and item amount is #{cart_item.amount}"
            if deal.trigger_amount.present? and cart_item.amount >= deal.deal_amount
              logger.debug "Deal is achieved"
              multiplier = cart_item.amount / deal.deal_amount
              discount_amount += multiplier * cart_item.product.price
              discount = {
                deal_id: deal.id,
                deal_multiplier: multiplier
              }
              discounts.push(discount)
            end
          end

          # check for percentage-based deals
          if deal.type == 'PercentageDeal'
            discount_amount += (cart_item.amount - multiplier) * cart_item.product.price * deal.discount_percentage
            discount = {
              deal_id: deal.id,
              deal_multiplier: cart_item.amount
            }
            discounts.push(discount)
          end
        end
      end
    end
    return total_amount, discount_amount, discounts
  end
end
