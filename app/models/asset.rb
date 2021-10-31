class Asset
  include Mongoid::Document
  include Mongoid::Document
  include Mongoid::Timestamps
  include LikeSearchable

  field :full_name, type: String
  field :code, type: String
  field :main_activities, type: String

  validates :full_name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
end
