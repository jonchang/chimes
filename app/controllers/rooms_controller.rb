class RoomsController < ApplicationController

  def index
    if current_user.nil?
      redirect_to root_path
      return
    end
    @room = Room.new
  end

  def create
    begin
      @room = Conference.find(room_params[:conference]).rooms.create!(room_params.except(:conference))
      flash[:info] = "Created room #{@room.name}."
      redirect_to @room
    rescue Exception => e
      flash[:danger] = e.message
      redirect_to conferences_path
    end
  end

  def add_event_type
    @room = Room.find(params[:id])
    begin
      if event_type_params[:warning_time_used].to_i == 1
        if event_type_params[:warning_time].nil?
          flash[:danger] = 'Warning time cannot be blank.'
          redirect_to @room and return
        end
      end
      if event_type_params[:passing_time_used].to_i == 1
        if event_type_params[:passing_time].nil?
          flash[:danger] = 'Passing time cannot be blank.'
          redirect_to @room and return
        end
      end
      @room.conference.event_types.create!(event_type_params.except(:warning_time_used, :passing_time_used))
      flash[:info] = 'Created new event type.'
    rescue Exception => e
      flash[:danger] = e.message
    end
    redirect_to @room
  end

  def add_event
    render status: 201, json: Room.find(params[:id]).events.create!(event_params).json_data
  end

  def show
    begin
      @room = Room.find(params[:id])
    rescue
      redirect_to conferences_path and return
    end
    if @room.conference.user != current_user
      redirect_to conferences_path
    end
  end

  def events_json
    begin
      @room = Room.find(params[:id])
    rescue
      render status: 403
    end
    if @room.conference.user != current_user
      render status: 403
    end
    render json: @room.events.map { |e| e.json_data }
  end

  def update
    begin
      @room = Room.find(params[:id])
    rescue
      flash[:danger] = 'Room does not exist.'
      redirect_to conferences_path and return
    end
    if @room.conference.user != current_user
      flash[:danger] = 'Room does not exist.'
      redirect_to conferences_path and return
    end
    begin
      @room.update!(update_params)
      flash[:info] = 'Changes saved.'
    rescue Exception => e
      flash[:danger] = e.message
    end
    redirect_to @room
  end

  def clone
    begin
      @room = Room.find(params[:id])
      @room.amoeba_dup.save
      flash[:info] = "Cloned room \"#{@room.name}\"."
    rescue Exception => e
      flash[:danger] = e.message
    end
    redirect_to @room.conference
  end

  def destroy
    begin
      @room = Room.find(params[:id])
      Room.destroy(params[:id])
      flash[:info] = "Deleted room \"#{@room.name}\"."
    rescue Exception => e
      flash[:danger] = e.message
    end
    redirect_to @room.conference
  end

  private

  def room_params
    params.require(:room).permit(:name, :conference)
  end

  def update_params
    params.require(:room).permit(:name)
  end

  def event_params
    params.require(:event).permit(:datetime, :event_type_id)
  end

  def event_type_params
    params.require(:event_type).permit(:name, :length, :warning_time, :passing_time, :warning_time_used, :passing_time_used)
  end


end
