class EventTypesController < ApplicationController

  def show
    @event_type = EventType.find(params[:id])
    render layout: false
  end

  def update
    @event_type = EventType.find(params[:id])
    p = update_params
    if p[:warning_time_used].to_i == 1
      if p[:warning_time].empty?
        redirect_to @event_type and return
      end
    end
    if p[:passing_time_used].to_i == 1
      if p[:passing_time].empty?
        redirect_to @event_type and return
      end
    end
    p[:warning_time] = nil if p[:warning_time_used].to_i == 0
    p[:passing_time] = nil if p[:passing_time_used].to_i == 0
    @event_type.update!(p.except(:warning_time_used, :passing_time_used))
    redirect_to @event_type
  end

  def destroy
    EventType.destroy(params[:id])
    render status: 200, json: { id: params[:id] }
  end

  def update_params
    params.require(:event_type).permit(:warning_time, :warning_time_used, :passing_time, :passing_time_used)
  end

end
