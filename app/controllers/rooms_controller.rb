class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[show edit update destroy add_user remove_user complete]
  before_action :authorize_admin, only: %i{new create complete}

  # GET /rooms or /rooms.json
  def index
    @rooms = current_user.admin? ? Room.all : current_user.rooms
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    unless current_user.admin? || @room.users.include?(current_user)
      redirect_to rooms_path, alert:"No tienes acceso a esta room"
    end
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
    
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    respond_to do |format|
      if @room.save
        UserRoom.create(room: @room, user: current_user)
        format.turbo_stream {render turbo_stream: turbo_stream.append("user_#{current_user.id}_rooms", partial:'shared/room', locals:{room: @room})}
      else
        format.turbo_stream {render turbo_stream: turbo_stream.replace('room_form', partial:'rooms/form', locals: {room: @room})}
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update room_params
        format.turbo_stream {render turbo_stream: turbo_stream.replace("room_#{@room.id}", partial:'shared/room', locals:{room: @room})}
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
   
  end

  def complete
    if @room.update(completed: true)
      respond_to do |format|
        format.html { redirect_to @room, notice: 'La tarea ha sido marcada como completada.' }
        format.turbo_stream do
          # Pasa `current_user` explícitamente al parcial
          render turbo_stream: turbo_stream.replace("room_#{@room.id}", partial: 'shared/room', locals: { room: @room, current_user: current_user })
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to @room, alert: 'Hubo un problema al cerrar la tarea.' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("room_#{@room.id}", partial: 'shared/error', locals: { message: 'Hubo un problema al cerrar la tarea.' }) }
      end
    end
  end

  def add_user

    unless current_user.admin?
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("rooms_controller", partial: 'shared/error', locals: { message: "No tienes permiso para agregar usuarios." }) }
        format.html { redirect_to rooms_path, alert: "No tienes permiso para agregar usuarios." }
      end
      return
    end
  
    begin
      UserRoom.create!(room: @room, user_id: params[:user_id])
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("room_show_#{@room.id}", partial: 'rooms/room', locals: { room: @room }) }
        format.html { redirect_to @room, notice: "Usuario agregado con éxito." }
      end
    rescue => e
      logger.error "Error al agregar usuario: #{e.message}"
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("rooms_controller", partial: 'shared/error', locals: { message: "Error al agregar usuario: #{e.message}" }) }
        format.html { redirect_to rooms_path, alert: "Se produjo un error: #{e.message}" }
      end
    end
  end

  def remove_user
    unless current_user.admin?
      
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("rooms_controller", partial: 'shared/error', locals: { message: "No tienes permiso para eliminar usuarios." }) }
        format.html { redirect_to rooms_path, alert: "No tienes permiso para eliminar usuarios." }
      end
      return
    end
  
    user_room = UserRoom.find_by(room: @room, user_id: params[:user_id])
    if user_room
      user_room.destroy
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("room_show_#{@room.id}", partial: 'rooms/room', locals: { room: @room }) }
        format.html { redirect_to @room, notice: "Usuario eliminado con éxito." }
      end
    else
      redirect_to @room, alert: "Usuario no encontrado en esta room"
    end
  end


 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id] )
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :estimated_end_time, :complete)
    end

    def authorize_admin
      unless current_user&.admin?
        redirect_to rooms_path, alert: "No tienes permiso para esta acción"
      end
    end
end
