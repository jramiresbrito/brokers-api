class OwnedAssetSerializer < ApplicationSerializer
  attributes :amount

  belongs_to :asset
end
