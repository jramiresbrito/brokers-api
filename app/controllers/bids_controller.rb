class BidsController < ApplicationController
  before_action :find_asset, only: :create
  before_action :set_bid, only: :show

  def create
    @bid = Bid.new(bid_params)
    @bid.broker = logged_in_broker
    @bid.asset = @asset

    create_resource_with_event(@bid, :bid_created)
  end

  def show
    render json: @bid
  end

  private

  def bid_params
    params.require(:bid).permit(:asset_code, :amount, :value)
  end

  def find_asset
    @asset = Asset.find_by(code: params[:asset_code])
  end

  def set_bid
    @bid = Bid.includes(:broker, :asset).find(params[:id])
  end

  def searchable_params
    params.permit({ search: {} }, { page: {} }, :include)
  end
end
