class OwnedAsset
  include Mongoid::Document
  include Mongoid::Timestamps
  include LikeSearchable

  belongs_to :broker
  belongs_to :asset

  field :amount, type: Integer

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
