class Bid
  include Mongoid::Document
  include Mongoid::Timestamps
  include LikeSearchable

  belongs_to :broker
  belongs_to :asset

  field :amount, type: Integer
  field :value, type: Float

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :value, presence: true, numericality: { greater_than: 0.0 }
end
