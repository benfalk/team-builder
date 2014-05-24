class TeamNotificationsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @notifications = team.stream.notifications
    respond_to do |format|
      format.html
      format.json { render json: @notifications }
    end
  end

  def create
    @notification = team.stream.notifications.build(notification_params)
    respond_to do |format|
      if @notification.save
        format.html { redirect_to team_url(team) }
        format.json { render json: @notification }
      else
        format.html { redirect_to team_url(team), alert: 'Unable to create message' }
        format.json { render json: @notification.errors.full_messages }
      end
    end
  end

  private

  def team
    @team ||= current_user.teams.find(params[:team_id])
  end

  def notification_params
    params.require(:notification).permit(:message).tap do |parms|
      parms[:source] = current_user
      parms[:notification_type] = :message
    end
  end

end
