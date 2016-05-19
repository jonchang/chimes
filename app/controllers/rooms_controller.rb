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
    room.conference.event_types.create!({name: event_type_params[:name], length: event_type_params[:length], warning_time: event_type_params[:warning_time] if event_type_params[:warning_time_used], warning_time: event_type_params[:passing_time] if event_type_params[:passing_time_used]})
    redirect_to @room
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

  private

  def room_params
    params.require(:room).permit(:name, :conference)
  end

  def update_params
    params.require(:room).permit(:name)
  end

  def event_type_params
    params.require(:room).permit(:name, :length, :warning_time_used, :warning_time, :passing_time_used, :passing_time)
  end

end
