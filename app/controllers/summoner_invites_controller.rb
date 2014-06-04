class SummonerInvitesController < ApplicationController
  
  before_action :authenticate_user!

  def create
    @invite = team.summoner_invites.build(create_params)
    respond_to do |format|
      if @invite.save
        format.html { redirect_to new_team_membership_url(team), notice: "Alert Sent" }
      else
        format.html { respond_to new_team_membership_url(team), notice: 'Unable to send invite' }
      end
    end
  end

  def update
    @invite = current_user.team_invites.find(params[:id])
    respond_to do |format|
      if @invite.update(update_params)
        format.html { redirect_to overview_account_url, notice: "You have #{@invite.status}" }
      else
        format.html { redirect_to overview_account_url, notice: 'Unable to perform action on invite at this time' }
      end
    end
  end

  private

  def team
    @team ||= Team.find(params[:team_id])
  end

  def create_params
    params.require(:team_summoner_invite).permit(:summoner_id)
  end

  def update_params
    params.require(:team_summoner_invite).permit(:status)
  end

end
