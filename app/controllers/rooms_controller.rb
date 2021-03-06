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
      conference = Conference.find(room_params[:conference])
      @room = conference.rooms.create!(room_params.except(:conference))
      flash[:info] = "Created room #{@room.name}."
      redirect_to @room
    rescue Exception => e
      flash[:danger] = e.message
      if conference.nil?
        redirect_to conferences_path
      else
        redirect_to conference
      end
    end
  end

  def add_event_type
    @room = Room.find(params[:id])
    begin
      if event_type_params[:warning_time_used].to_i == 1
        if event_type_params[:warning_time].empty?
          flash[:danger] = 'Warning time cannot be blank.'
          redirect_to @room and return
        end
      end
      if event_type_params[:passing_time_used].to_i == 1
        if event_type_params[:passing_time].empty?
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

  def clone_day
    @room = Room.find(params[:id])
    from = DateTime.parse(clone_params[:from])
    to = DateTime.parse(clone_params[:to])
    delta = to - from
    @room.transaction do
      remove = @room.events.where('datetime BETWEEN ? AND ?', to.beginning_of_day, to.end_of_day).destroy_all.map(&:id)
      @room.events.where('datetime BETWEEN ? AND ?', from.beginning_of_day, from.end_of_day).each do |e|
        ep = e.amoeba_dup
        ep.datetime += delta.days
        ep.save!
      end
      add = @room.events.where('datetime BETWEEN ? AND ?', to.beginning_of_day, to.end_of_day).map(&:json_data)
      render status: 201, json: {remove: remove, add: add}
    end
  end

  def show
    begin
      @room = Room.find(params[:id])
    rescue
      redirect_to conferences_path and return
    end
    if not @room.conference.permitted? current_user
      redirect_to conferences_path
    end
  end

  def events_json
    begin
      @room = Room.find(params[:id])
    rescue
      render status: 403 and return
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
    if not @room.conference.permitted? current_user
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

  def clone_params
    params.require(:room).permit(:from, :to)
  end

  def event_params
    params.require(:event).permit(:datetime, :event_type_id)
  end

  def event_type_params
    params.require(:event_type).permit(:name, :length, :warning_time, :passing_time, :warning_time_used, :passing_time_used)
  end

end
