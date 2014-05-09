class Users::RegistrationsController < Devise::RegistrationsController

  # GET /users/sign_up
  def new
    @summoner = Summoner.find(params[:summoner])
    build_resource({summoner_id: @summoner.id})
    
  end

end
