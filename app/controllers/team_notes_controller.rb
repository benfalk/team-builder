class TeamNotesController < ApplicationController

  def create
    @note = team.team_notes.build(create_params)
    respond_to do |format|
      if @note.save
        format.html { redirect_to team_url(team), status: 'Note Created' }
        format.json { render json: { success: true, errors: @note.errors.full_messages } }
      else
        format.html { redirect_to team_url(team), alert: 'Note Creation Failed' }
        format.json { render json: { success: false, errors: @note.errors.full_messages } }
      end
    end
  end

  def update
    @note = team.team_notes.find(params[:id])
    respond_to do |format|
      if @note.update(update_params)
        format.html { redirect_to team_url(team), status: 'Note Created' }
        format.json { render json: { success: true, errors: @note.errors.full_messages } }
      else
        format.html { redirect_to team_url(team), alert: 'Note Creation Failed' }
        format.json { render json: { success: false, errors: @note.errors.full_messages } }
      end
    end
  end

  private

  def team
    @team ||= Team.find(params[:team_id])
  end

  def create_params
    params.require(:team_note).permit(
      :league_replay,
      :note
    ).tap do |p|
      p[:game_id] = team.game_ids.include?(p[:game_id]) ? p[:game_id] : nil
    end
  end

  def update_params
    params.require(:team_note).permit(
      :league_replay,
      :note
    )
  end

end
