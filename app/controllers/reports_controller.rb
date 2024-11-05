class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:create]
  before_action :set_report, only: [:show, :update]

  def index
    @rooms = Room.where(completed:true).includes(:report)
  end

  def show
    @messages = @report.room.messages.includes(:user)
  end

  def create
    @report = @room.build_report(user: current_user, description: params[:description])
    if @report.save 
      redirect_to report_path(@report), notice:'informe creado con exito'
    else
      redirect_to room_path, alert:'No se pudo crear el informe'
    end
  end

  def update
    message = Message.find(params[:message_id])
    @report.message_tags.create(message: message, tagged_by: current_user)

    redirect_to report_path(@report), notice: 'Mensaje etiquetado en el informe'
  end


  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_report
    @report = Report.find(params[:id])
  end
end
