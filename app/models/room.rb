class Room < ApplicationRecord
  validates :name, presence: true
  has_one :report
  has_many :user_rooms
  has_many :users, through: :user_rooms
  has_many :messages

  after_update_commit :update_room_details
  before_save :set_completion_attributes, if: :completed_changed?
  def finished?
    completed || (estimated_end_time.present? && Time.current > estimated_end_time)
  end



  private

  def update_room_details
    if defined?(current_user) && current_user.present?
      broadcast_replace_to('room_details_channel', partial: 'shared/room', locals: { room: self }, target: "room_#{self.id}")
    end  
  end

  def set_completion_attributes
    if completed
      self.completion_date = Date.current
      self.completion_time = Time.current
    else
      self.completion_date = nil
      self.completion_time = nil
    end
  end
end
