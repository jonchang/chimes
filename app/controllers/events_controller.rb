class EventsController < ApplicationController

  def update
    render json: Event.find(params[:id]).update!(update_params)
  end

  def destroy
    Event.delete(params[:id])
    render status: 200, json: {'id': params[:id]}
  end

  private

  def update_params
    params.require(:event).permit(:datetime)
  end

end
