class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:create]
  before_action :set_report, only: [:show, :update] # Excluir worker_efficiency
  before_action :authorize_admin, only: [:index, :show, :create, :update, :worker_efficiency]

  def index
    @rooms = Room.where(completed: true).includes(:report)
  end

  def show
    @messages = @report.room.messages.includes(:user)
  end

  def create
    @report = @room.build_report(user: current_user, description: params[:description])
    if @report.save 
      redirect_to report_path(@report), notice: 'Informe creado con éxito'
    else
      redirect_to room_path(@room), alert: 'No se pudo crear el informe'
    end
  end

  def update
    message = Message.find(params[:message_id])
    message_tag = @report.message_tags.find_by(message: message)

    if message_tag
      message_tag.destroy
      notice = 'Etiqueta eliminada del informe'
    else
      @report.message_tags.create(message: message, tagged_by: current_user)
      notice = 'Tarea etiquetada en el informe'
    end
    redirect_to report_path(@report), notice: notice
  end

  def worker_efficiency
    @worker_efficiency_report = worker_efficiency_data

  respond_to do |format|
    format.turbo_stream do
      render partial: 'reports/worker_efficiency_data', locals: { worker_efficiency_report: @worker_efficiency_report }
    end
    format.html do
      render 'worker_efficiency' # Esta vista renderiza el Turbo Frame y carga el parcial
    end
  end
  end

  
  private
# Acción de worker_efficiency
def worker_efficiency_data
  # Agrupa las tareas completadas por usuario
  completed_tasks_by_user = UserRoom.joins(:room).where(rooms: { completed: true }).group_by(&:user_id)

  # Mapea cada usuario y sus tareas completadas
  @worker_efficiency_report = completed_tasks_by_user.map do |user_id, user_rooms|
    user = User.find(user_id)
    rooms = user_rooms.map(&:room) # Obtiene todas las Room completadas asociadas a este usuario

    # Calcula el tiempo total de completitud y el tiempo promedio
    total_time = rooms.sum { |room| (room.updated_at - room.created_at) / 1.hour }
    average_completion_time = rooms.size.positive? ? (total_time / rooms.size).round(2) : 0

    # Calcula el porcentaje de tareas completadas a tiempo
    on_time_count = rooms.count { |room| room.updated_at <= room.estimated_end_time }
    on_time_percentage = rooms.size.positive? ? ((on_time_count.to_f / rooms.size) * 100).round(2) : 0

    tareas_tarde_contar = rooms.size - on_time_count
    tareas_tarde_porcentaje = rooms.size.positive? ? ((tareas_tarde_contar.to_f / rooms.size) * 100).round(2) : 0

    # Devuelve un hash con los datos de eficiencia para el usuario
    {
      user: user,
      completed_tasks: rooms.size,
      average_completion_time: average_completion_time,
      on_time_percentage: on_time_percentage,
      late_task_count: tareas_tarde_contar,
      late_task_percentage: tareas_tarde_porcentaje,
    }
  end
end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_report
    # Solo ejecuta si params[:id] está presente y se necesitan reportes específicos
    @report = Report.find(params[:id]) if params[:id]
  end

  def authorize_admin
    unless current_user&.admin?
      redirect_to rooms_path, alert: "No tienes permisos para ver esta sección"
    end
  end
end