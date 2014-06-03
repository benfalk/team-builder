class RequestsController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    @requests = current_user.team_requests
  end

  def create
    @request = current_user.team_requests.build(request_params)
    respond_to do |format|
      if @request.save
        format.html { redirect_to team_url(params[:team_request][:team_id]), notice: 'Request Sent' }
        format.json { render json: { success: true, errors: @request.errors.full_messages } }
      else
        format.html { redirect_to team_requests_url, alert: 'Request Failed' }
        format.json { render json: { success: false, errors: @request.errors.full_messages } }
      end
    end
  end

  def destroy
    @request = current_user.team_requests.find(params[:id])  
    @request.destroy
    respond_to do |format|
      format.html { redirect_to team_requests_url, notice: 'Request Deleted' }
      format.json { render json: { success: true, errors: [] } }
    end
  end

  private

  def request_params
    params.require(:team_request).permit(:team_id)
  end
  
end
