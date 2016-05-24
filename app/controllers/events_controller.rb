class EventsController < ApplicationController

  def update
    render json: Event.find(params[:id]).update!(update_params)
  end

  private

  def update_params
    params.require(:event).permit(:datetime)
  end

end
