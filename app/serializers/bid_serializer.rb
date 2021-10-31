class BidSerializer < ApplicationSerializer
  attributes :id, :amount, :value

  belongs_to :asset
  belongs_to :broker
end
