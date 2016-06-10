class ConferencesController < ApplicationController

  def index
    if current_user.nil?
      redirect_to root_path
      return
    end
    @conference = Conference.new
  end

  def create
    begin
      @conference = Conference.create!(conference_params)
      Manager.create!(user: current_user, conference: @conference, admin: true)
      flash[:info] = "Created conference #{@conference.name}."
      redirect_to @conference
    rescue Exception => e
      flash[:danger] = e.message
      redirect_to conferences_path
    end
  end

  def show
    begin
      @conference = Conference.find(params[:id])
    rescue
      redirect_to conferences_path and return
    end
    if not @conference.permitted? current_user
      redirect_to conferences_path and return
    end
    @room = Room.new
  end

  def update
    begin
      @conference = Conference.find(params[:id])
    rescue
      flash[:danger] = 'Conference does not exist.'
      redirect_to conferences_path and return
    end
    if not @conference.permitted? current_user
      flash[:danger] = 'Conference does not exist.'
      redirect_to conferences_path and return
    end
    begin
      @conference.update!(update_params.except(:dummy))
      Manager.create!(user: current_user, conference: @conference, admin: true)
      flash[:info] = 'Changes saved.'
    rescue Exception => e
      flash[:danger] = e.message
    end
    redirect_to @conference
  end

  private

  def conference_params
    params.require(:conference).permit(:name)
  end

  def update_params
    params.require(:conference).permit(:time_zone, :dummy, user_ids: [])
  end

end
