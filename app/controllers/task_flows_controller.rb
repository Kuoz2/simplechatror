class TaskFlowsController < ApplicationController
  before_action :authenticate_user!
  def index
    # Filtra las rooms completadas con `completion_date` y `estimated_end_time` definidos
    @completed_rooms = Room.where(completed: true).where.not(completion_date: nil)

    # Filtra las rooms terminadas a tiempo y fuera de tiempo
    @on_time_rooms = @completed_rooms.select { |room| room.completion_date <= room.estimated_end_time }
    @late_rooms = @completed_rooms - @on_time_rooms

    # Agrupa las tareas por mes de finalización
    @on_time_rooms_by_month = @on_time_rooms.group_by { |room| room.completion_date.strftime("%B %Y") } || {}
    @late_rooms_by_month = @late_rooms.group_by { |room| room.completion_date.strftime("%B %Y") } || {}

    # Calcula el porcentaje de tareas completadas a tiempo
    @on_time_percentage = if @completed_rooms.any?
                            (@on_time_rooms.count.to_f / @completed_rooms.count * 100).round(2)
                          else
                            0
                          end

    # Calcula el porcentaje de tareas completadas y fuera de tiempo por mes
    @monthly_completion_percentage = {}
    all_months = (@on_time_rooms_by_month.keys + @late_rooms_by_month.keys).uniq
    all_months.each do |month|
      total_tasks = (@on_time_rooms_by_month[month]&.size || 0) + (@late_rooms_by_month[month]&.size || 0)
      on_time_count = @on_time_rooms_by_month[month]&.size || 0
      late_count = @late_rooms_by_month[month]&.size || 0

      if total_tasks > 0
        @monthly_completion_percentage[month] = {
          on_time: ((on_time_count.to_f / total_tasks) * 100).round(2),
          late: ((late_count.to_f / total_tasks) * 100).round(2)
        }
      else
        @monthly_completion_percentage[month] = { on_time: 0, late: 0 }
      end
    end
  end
end
