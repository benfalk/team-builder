class TeamRequestsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @requests = team.requests
    respond_to do |format|
      format.html
      format.json { render json: @requests }
    end
  end

  def update
    @request = team.requests.find(params[:id])
    respond_to do |format|
      if @request.update(request_update_attrs)
        format.html { redirect_to team_url(team) }
        format.json { render json: @request }
      else
        format.html { redirect_to team_url(team), alert: 'Unable to apply to request' }
        format.json { render json: @request.errors.full_messages }
      end
    end
  end

  private

  def request_update_attrs
    params.require(:team_request).permit(:status)
  end

  def team
    @team ||= current_user.teams.find(params[:team_id])
  end

end
