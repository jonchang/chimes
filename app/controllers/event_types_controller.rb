class EventTypesController < ApplicationController

  def destroy
    EventType.destroy(params[:id])
    render status: 200, json: { id: params[:id] }
  end

end
