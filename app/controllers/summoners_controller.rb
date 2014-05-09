class SummonersController < ApplicationController
  
  def create
    @summoner = Summoner.prepare_binding(create_params)
    respond_to do |format|
      if @summoner.save
        format.html { redirect_to new_user_registration_url }
      else
        format.html { render 'pages/index' }
      end
    end
  end

  private

  def create_params
    params.require(:summoner).permit(:name,:region)
  end


end
