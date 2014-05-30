class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :set_summoner, only:[:create]

  # GET /users/sign_up
  def new
    @summoner = Summoner.find(params[:summoner])
    build_resource({summoner: @summoner})
  end

  private

  def sign_up_params
    params.require(
      :user
    ).permit(
      :first_name,
      :last_name,
      :skype,
      :location_city,
      :location_state,
      :short_bio,
      :password,
      :password_confirmation,
      :summoner_id,
      :email,
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

  def set_summoner
    @summoner = Summoner.find(params[:user][:summoner_id])
  end


end
