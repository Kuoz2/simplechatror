class Room < ApplicationRecord
  validates :name, presence: true
  has_many :user_rooms
  has_many :users, through: :user_rooms
  has_many :messages

  after_update_commit :update_room_details

  def finished?
    completed || (estimated_end_time.present? && Time.current > estimated_end_time)
  end


  private
  def update_room_details
    if defined?(current_user) && current_user.present?
      broadcast_replace_to('room_details_channel', partial: 'shared/room', locals: { room: self }, target: "room_#{self.id}")
    end  end
end
