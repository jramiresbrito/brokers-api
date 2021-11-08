# The Asset class represents the values that are negotiated through the Exchange-API.
# An Asset can be *purchased* or *selled* by a {Broker}.
#
# @author Joao Victor Ramires Guimaraes Brito
#
#
# @!attribute bid
#   @return [Bid]
#   The related Bids
#
#   == Validations:
#   - presence
#
#
# @!attribute full_name
#   @return [String]
#   The name of the related company.
#
#   == Validations:
#   - presence
#   - unique
#
#
# @!attribute code
#   @return [String]
#   The Asset code.
#
#   == Validations:
#   - presence
#   - unique
#
#
# @!attribute main_activies
#   @return [String]
#   The fields that the related company works with.
class Asset
  include Mongoid::Document
  include Mongoid::Timestamps
  include LikeSearchable

  has_many :bids

  field :full_name, type: String
  field :code, type: String
  field :main_activities, type: String

  validates :full_name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
end
