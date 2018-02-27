class CartItemsController < ApplicationController
  def new
    @cart_item = CartItem.new
  end

  # DELETE /cart_item/1
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    respond_to do |format|
      format.html { redirect_to '/cart', notice: 'The item was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def add_to_cart
    @cart = Cart.find_by(user_id: params[:user_id])
    if @cart.present?
      @cart_item = CartItem.new(cart_id: @cart.id, product_id: params[:product_id], amount: 1)
      respond_to do |format|
        if @cart_item.save
          format.html { redirect_to @cart, notice: 'The item was added to your cart.' }
          format.json { render :show, status: :created, location: @cart }
        else
          format.html { render :new }
          format.json { render json: @cart_item.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end
end