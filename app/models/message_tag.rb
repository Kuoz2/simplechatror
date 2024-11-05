class MessageTag < ApplicationRecord
  belongs_to :report
  belongs_to :message
  belongs_to :tagged_by, class_name: 'User', foreign_key: 'tagged_by_id'
end
