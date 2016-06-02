class EventsController < ApplicationController

  def update
    event = Event.find(params[:id])
    event.update!(update_params)
    render status: 200, json: event.json_data
  end

  def destroy
    Event.delete(params[:id])
    render status: 200, json: { id: params[:id] }
  end

  private

  def update_params
    params.require(:event).permit(:datetime)
  end

end
