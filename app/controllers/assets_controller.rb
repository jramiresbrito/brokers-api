class AssetsController < ApplicationController
  skip_before_action :authorized, only: %i[index show]
  before_action :set_asset, only: %i[show]

  def index
    records = Asset.all
    @assets = LoadModelService.new(records, searchable_params)
    @assets.call

    render json: @assets.records, meta: pagination_dict(@assets.records)
  end

  def show
    render json: @asset
  end

  private

  def set_asset
    @asset = Asset.find(params[:id])
  end

  def searchable_params
    params.permit({ search: {} }, { page: {} }, { order: {} }, { asset: {} })
  end
end
