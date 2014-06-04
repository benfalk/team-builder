class MembershipsController < ApplicationController
  
  before_action :authenticate_user!, only:[:update,:create,:destroy]

  def edit
    @team = Team.find(params[:team_id])
    @membership = @team.team_memberships.find(params[:id])
  end

  def new
    @team = Team.find(params[:team_id])
    @membership = @team.team_memberships.build
    @canidates = User.includes(:favorite_champions,:summoner).where.not(id: @team.user_ids).page(params[:page])
  end

  def index
    @team = Team.including_membership_data.find(params[:team_id])
    @memberships = @team.team_memberships
    respond_to do |format|
      format.html
      format.json { render json: @memberships }
    end
  end

  def update
    @team = Team.find(params[:team_id])
    @membership = @team.team_memberships.find(params[:id])
    respond_to do |format|
      if @membership.update(update_params)
        format.html { redirect_to new_team_membership_url(@team) }
        format.json { render json: { success: true, errors: @membership.errors.full_messages } }
      else
        format.html { redirect_to new_team_membership_url(@team), alert: 'Unable to update team member' }
        format.json { render json: { success: false, errors: @membership.errors.full_messages } }
      end
    end
  end

  def create
    @team = Team.find(params[:team_id])
    @membership = @team.team_memberships.build(create_params)
    respond_to do |format|
      if @membership.save
        format.html { redirect_to new_team_membership_url(@team), notice: "#{@membership.summoner_name} added!" }
        format.json { render json: { success: true, errors: @membership.errors.full_messages } }
      else
        format.html { redirect_to new_team_membership_url(@team), alert: 'Unable to add team member' }
        format.json { render json: { success: false, errors: @membership.errors.full_messages } }
      end
    end
  end

  def destroy
    @membership = Team.find(params[:team_id]).team_memberships.find(params[:id])
    respond_to do |format|
      if @membership.destroy
        format.html { redirect_to new_team_membership_url(@membership.team) }
        format.json { render json: { success: true, errors: @membership.errors.full_messages } }
      else
        format.html { redirect_to new_team_membership_url(@membership.team), alert: 'Unable to remove team member' }
        format.json { render json: { success: false, errors: @membership.errors.full_messages } }
      end
    end
  end

  private

  def update_params
    params.require(
      :team_membership
    ).permit(
      :role_id
    )
  end

  def create_params
    params.require(
      :team_membership
    ).permit(
      :role_id,
      :summoner_id,
      :summoner_name
    )
  end
  
end
