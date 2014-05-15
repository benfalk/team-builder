class SummonersController < ApplicationController
  
  def create
    @summoner = Summoner.prepare_binding(create_params)
    respond_to do |format|
      if @summoner.save
        format.html { redirect_to new_user_registration_url(summoner: @summoner.id) }
      else
        format.html { render 'pages/index' }
      end
    end
  end

  def lookup
    @summoner = Summoner.prepare_binding(params.permit(:name,:region))
    respond_to do |format|
      if @summoner.id || @summoner.save
        format.html
        format.json { render json: @summoner }
      else
        format.html
        format.json { render json: @summoner.errors.full_messages, status: 400 }
      end
    end
  end

  private

  def create_params
    params.require(:summoner).permit(:name,:region)
  end


end
