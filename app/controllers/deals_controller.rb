class DealsController < ApplicationController
  after_action :verify_authorized

  def index
    authorize Deal
    @deals = Deal.all
  end

  # GET /deals/new
  def new
    authorize Deal
    @deal = Deal.new
  end

  def edit
    authorize Deal
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

  def update
    authorize Deal
  end

  def destroy
    authorize Deal
  end

  private

  # Only allow the whitelisted parameters.
  def deal_params
    params.require(:deal).permit(:deal_type, :product_id, :trigger_amount, :deal_amount, :discount_percentage)
  end
end
