# The Bid class represent a request to negotiate an {Asset}. It's nature can be
# *buy* or *sell*, and can be verified through the {Bid#operation}.
#
# @author Joao Victor Ramires Guimaraes Brito
#
#
# @!attribute broker
#   @return [Broker]
#   An instance of a {Broker} that wants to negotiate.
#
#   == Validations:
#   - presence
#
#
# @!attribute asset
#   @return [Asset]
#   An instance of the {Asset} being negotiated.
#
#   == Validations:
#   - presence
#
#
# @!attribute amount
#   @return [Integer]
#   The amount being negotiated.
#
#   == Validations:
#   - presence
#   - must be a positive Integer
#
#
# @!attribute value
#   @return [Float]
#   The unit value.
#
#   == Validations:
#   - presence
#   - must be a positive float.
#
#
# @!attribute operation
#   @return [String]
#   The bid nature.
#
#   == Validations:
#   - presence
#   - must 'buy' or 'sell'.
class Bid
  include Mongoid::Document
  include Mongoid::Timestamps
  include LikeSearchable

  belongs_to :broker
  belongs_to :asset

  field :amount, type: Integer
  field :value, type: Float
  field :operation, type: String

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :value, presence: true, numericality: { greater_than: 0.0 }
end
