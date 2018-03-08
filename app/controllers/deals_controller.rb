class DealsController < ApplicationController
  after_action :verify_authorized

  # GET /deals
  def index
    authorize Deal
    @deals = Deal.all
  end

  # GET /deals/new
  def new
    authorize Deal
    @deal = Deal.new
  end

  # GET /products/1/edit
  def edit
    authorize Deal
    @deal = Deal.find(params[:id])
  end

  # POST /deals
  def create
    authorize Deal
    @deal = Deal.new(deal_params)
    # input param for percentage is 1..100, transform to float
    @deal.discount_percentage = @deal.discount_percentage / 100

    respond_to do |format|
      if @deal.save
        format.html { redirect_to deals_path, notice: 'The deal has been created successfully.' }
        format.json { render :index, status: :created, location: @deal }
      else
        format.html { render :new }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
        format.js   { render :new, content_type: 'text/javascript' }
      end
    end
  end

  # PATCH/PUT /deals/1
  def update
    authorize Deal
    @deal = Deal.find(params[:id])
    logger.debug params[:deal][:discount_percentage]
    params[:deal][:discount_percentage] = params[:deal][:discount_percentage].to_f / 100

    respond_to do |format|
      if @deal.update(deal_params)
        format.html { redirect_to deals_path, notice: 'The deal was successfully updated.' }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
        format.js   { render :edit, content_type: 'text/javascript' }
      end
    end
  end

  # DELETE /deals/1
  def destroy
    authorize Deal
    @deal = Deal.find(params[:id])
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to deals_path, notice: 'The deal was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

  # Only allow the whitelisted parameters.
  def deal_params
    params.require(:deal).permit(:type, :product_id, :trigger_amount, :deal_amount, :discount_percentage)
  end
end
