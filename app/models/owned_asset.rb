# The OwnedAsset class represent the consolidation of an {Asset} ownership transfer.
# When a Transaction occurs in the Exchange-API, a OwnedAsset will be created in
# Brokers-API so the {Broker}'s can see their possessions.
#
# @author Joao Victor Ramires Guimaraes Brito
#
#
# @!attribute buyer
#   @return [Broker]
#   An instance of a {Broker} that *bought* the {Asset}.
#
#   == Validations:
#   - presence
#
#
# @!attribute broker
#   @return [Broker]
#   An instance of a {Broker} that owns the OwnedAsset.
#
#   == Validations:
#   - presence
#
#
# @!attribute asset
#   @return [Asset]
#   An instance of the {Asset} owned by the {Broker}.
#
#   == Validations:
#   - presence
#
#
# @!attribute amount
#   @return [Integer]
#   The amount owned.
#
#   == Validations:
#   - presence
#   - must be a positive Integer
class OwnedAsset
  include Mongoid::Document
  include Mongoid::Timestamps
  include LikeSearchable

  belongs_to :broker
  belongs_to :asset

  field :amount, type: Integer

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
