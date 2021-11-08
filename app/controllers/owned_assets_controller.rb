class OwnedAssetsController < ApplicationController
  before_action :set_owned_asset, only: %i[show]

  def index
    broker_assets = OwnedAsset.where(broker: logged_in_broker.id)
    @owned_assets = LoadModelService.new(broker_assets, searchable_params)
    @owned_assets.call

    if @owned_assets.records.empty?
      render json: '[]'
    else
      render json: @owned_assets.records, meta: pagination_dict(@owned_assets.records)
    end
  end

  private

  def searchable_params
    params.permit({ search: {} }, { page: {} }, { order: {} }, { owned_asset: {} })
  end
end
