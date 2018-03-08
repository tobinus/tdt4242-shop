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
    @cart = current_user.cart
    @cart_item = CartItem.new(cart_id: @cart.id, product_id: params[:product_id], amount: params[:amount])
    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to @cart, notice: 'The item was added to your cart.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
        format.js   { render :add_to_cart, content_type: 'text/javascript' }
      end
    end
  end

  private

  # Only allow the whitelisted parameters.
  def cart_item_params
    params.require(:cart_item).permit(:cart_id, :product_id, :amount)
  end
end