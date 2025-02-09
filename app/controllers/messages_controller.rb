class MessagesController < ApplicationController
  before_action :set_room, only: %i[create edit]
  before_action :set_message, only: %i[edit update destroy]
def create
    @message = @room.messages.new message_params
    @message.user = current_user
    
    respond_to do |format|
      if @message.save
        format.turbo_stream { render turbo_stream: turbo_stream.append("room_message_div", partial: "messages/message", locals: { message: @message }) }
        format.html { redirect_to room_path(@room), notice: "Mensaje enviado correctamente" }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("message_form", partial: "messages/form", locals: { room: @room, message: @message }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
end

def edit
  unless current_user.admin? || @message.user == current_user
    redirect_to room_path(@room), alert: "No tienes permiso para editar este mensaje"
  end
end

def update
  unless current_user.admin? || @message.user == current_user
    redirect_to room_path(@room), alert: "No tienes permiso para actualizar este mensaje"
    return
  end

  respond_to do |format|
    if @message.update message_params
      format.turbo_stream
    end
  end
end


def destroy
  @message = Message.find(params[:id]) # Asegurar que encontramos el mensaje
  @message.destroy

  respond_to do |format|
    format.turbo_stream { render turbo_stream: turbo_stream.remove("message_#{@message.id}") }
    format.html { redirect_to room_path(@message.room), notice: "Mensaje eliminado correctamente" }
  end
end

private

  def set_message
    @message = Message.find(params[:id])
  end

  def set_room
    @room = Room.find(params[:room_id])
    unless current_user.admin? || @room.users.include?(current_user)
      redirect_to rooms_path, alert: "No tienes acceso a los mensajes de esta room"
    end
  end

  def message_params
    params.require(:message).permit(:message, :image)
  end
end