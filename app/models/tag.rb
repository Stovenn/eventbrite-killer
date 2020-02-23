class Tag < ApplicationRecord
  has_many :event_tag_joins
  has_many :events, through: :event_tag_joins
end
