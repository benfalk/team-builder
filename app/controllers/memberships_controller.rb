class MembershipsController < ApplicationController
  
  before_action :authenticate_user!, only:[:update,:create,:destroy]

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
    @membership = @team.find(params[:id])
    respond_to do |format|
      if @membership.update(update_params)
        format.html { redirect_to teams_url(@team) }
        format.json { render json: { success: true, errors: @membership.errors.full_messages } }
      else
        format.html { redirect_to teams_url(@team), alert: 'Unable to update team member' }
        format.json { render json: { success: false, errors: @membership.errors.full_messages } }
      end
    end
  end

  def create
    @team = Team.find(params[:team_id])
    @membership = @team.team_memberships.build(create_params)
    respond_to do |format|
      if @membership.save
        format.html { redirect_to teams_url(@team) }
        format.json { render json: { success: true, errors: @membership.errors.full_messages } }
      else
        format.html { redirect_to teams_url(@team), alert: 'Unable to add team member' }
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
      :summoner_id
    )
  end
  
end
