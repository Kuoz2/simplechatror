class Report < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :message_tags
end
