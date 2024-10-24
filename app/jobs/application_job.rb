class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
  queue_as :default

  def perform(user_room)
    # Realiza el broadcasting de forma segura
    room = user_room.room
    user_id = user_room.user_id
    broadcast_append_to(
      'users_rooms_channel',
      partial: 'shared/room',
      locals: { room: room },
      target: "user_#{user_id}_rooms"
    )
  end
end
