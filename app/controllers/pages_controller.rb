class PagesController < ApplicationController

  def index
  end

  def test
  end

  def conference
    @conference = Conference.find(params[:id])
  end

  def room
    @room = Room.find(params[:id])
  end

end
