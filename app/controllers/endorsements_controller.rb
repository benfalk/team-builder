class EndorsementsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @endorsement = current_user.endorsements.build(create_params)
    if @endorsement.save
      redirect_to "/#{@endorsement.skill.user.summoner.url}"
    else
      redirect_to "/#{@endorsement.skill.user.summoner.url}", alert: @endorsement.errors.full_messages.join(', ')
    end
  end

  def destroy
    @endorsement = current_user.endorsements.find(params[:id])
    @endorsement.destroy
    redirect_to skills_url
  end

  private

  def create_params
    params.require(:endorsement).permit(:skill_id)
  end

end
