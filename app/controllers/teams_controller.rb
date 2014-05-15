class TeamsController < ApplicationController
  
  before_action :authenticate_user!, only:[:new,:create,:edit]
  
  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_create_params)
    @team.team_memberships << TeamMembership.new(user: current_user, membership_type: :captain) 
    respond_to do |format|
      if @team.save
        format.html { redirect_to team_url(@team) }
        format.json { render json: { success: true, errors: @team.errors.full_messages } }
      else
        format.html { render 'teams/new' }
        format.json { render json: { success: false, errors: @team.errors.full_messages } }
      end
    end
  end

  def show
    @team = Team.includes(team_memberships:[{user:[:summoner]},:role]).find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @team }
    end
  end

  private

  def team_create_params
    params.require(
      :team
    ).permit(
      :avatar,
      :name,
      :game_style,
      :about_us
    )
  end

end
