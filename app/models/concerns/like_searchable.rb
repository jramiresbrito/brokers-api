module LikeSearchable
  extend ActiveSupport::Concern

  included do
    scope :like, ->(key, value) { where({ "#{key}": /.*#{value}.*/i }) }
  end
end
