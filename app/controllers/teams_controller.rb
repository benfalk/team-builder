class TeamsController < ApplicationController
  
  before_action :authenticate_user!, only:[:new,:create,:edit]

  def edit
    @team = Team.including_membership_data.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @team }
    end
  end

  def update
    @team = Team.including_membership_data.find(params[:id])
    respond_to do |format|
      if @team.update(team_create_params)
        format.html { redirect_to team_url(params[:id]), alert: 'Team updated' }
        format.json { render json: { success: true } }
      else
        format.html { render edit_team_path(params[:id]) }
        format.json { render json: { success: false, errors: @team.errors.full_messages } }
      end
    end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_create_params)
    @team.team_memberships << TeamMembership.new( user: current_user,
                                                  membership_type: :captain,
                                                  summoner: current_user.summoner ) 
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
    @team = Team.including_membership_data.find(params[:id])
    @team_games = @team.games.order(played_at: :desc)
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
      :play_style,
      :about_us
    )
  end

end
