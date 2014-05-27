class AccountsController < ApplicationController

  before_filter :authenticate_user!

  def edit
    @user = current_user
    @summoner = current_user.summoner
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update(update_params)
        format.html { redirect_to edit_account_url, alert: 'Account updated' }
        format.json { render json: { success: true } }
      else
        format.html { render 'account/edit' }
        format.json { render json: { success: false, errors: @user.errors.full_messages } }
      end
    end
  end

  def overview
    @game_stats = current_user.summoner
      .game_stats.non_bot_matches
      .includes({game:[:summoners,{game_stats:[:summoner]}]},:played_champion)
      .order(played_at: :desc)
  end

  private

  def update_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :location_city,
      :location_state,
      :short_bio,
      :play_style,
      :gaming_times,
      :avatar,
      { :favorite_role_ids => [] }
    ).tap do |p|
      if params[:favorite_champs]
        p[:favorite_champion_ids] = Champion.where(key: params[:favorite_champs]).pluck(:id)
      end
    end
  end

end
