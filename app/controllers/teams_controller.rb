class TeamsController < ApplicationController
  
  before_action :authenticate_user!, only:[:new,:create,:edit]
  before_action :only_captains!, only:[:edit,:update]
  delegate :is_member?, :is_team_captain?, :has_request_pending?, to: :user_questions

  class TeamCaptainOnlyException < Exception; end

  def edit
    @team = team
    respond_to do |format|
      format.html
      format.json { render json: @team }
    end
  end

  def update
    @team = team
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
    @team = team
    @team_games = @team.games.order(played_at: :desc).page(params[:page]).per(15)
    @skype_names = @team.users.skype_names
    @team_user_questions = team.user_questions(current_user)
    @is_a_member = is_member?
    @request_pending = has_request_pending?
    respond_to do |format|
      format.html
      format.json { render json: @team }
    end
  end

  def index
    if params[:all]
      @teams = Team.all
    else
      @teams = Team::MatchMaker.new(current_user).teams
    end
    @teams = @teams.including_membership_data
  end

  private

  def team
    @_t ||= Team.including_membership_data.find(params[:id])
  end

  def user_questions
    team.user_questions(current_user)
  end

  def only_captains!
    raise TeamCaptainOnlyException unless is_team_captain?
  end

  def team_create_params
    params.require(
      :team
    ).permit(
      :avatar,
      :name,
      :play_style,
      :gaming_times,
      :about_us
    )
  end

end
