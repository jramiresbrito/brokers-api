class OwnedAssetSerializer < ApplicationSerializer
  attributes :id, :amount

  belongs_to :asset
  belongs_to :broker
end
