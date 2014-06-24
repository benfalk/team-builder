class SkillsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @skills = current_user.skills.includes(endorsements:[:user])
  end

  def create
    @skill = Skill.new(create_params)

    respond_to do |format|
      if @skill.save
        format.html { redirect_to "/#{@skill.user.summoner.url}" }
        format.json { render json: { success: true, errors: @skill.errors.full_messages } }
      else
        format.html { redirect_to summoner_url(current_user.summoner), alert: 'Unable to create skill' }
        format.json { render json: { success: false, errors: @skill.errors.full_messages } }
      end
    end
  end

  def destroy
    @skill = current_user.skills.find(params[:id])
    @skill.destroy
    redirect_to "/#{current_user.summoner.url}"
  end

  private

  def create_params
    params.require(:skill).permit(:title,:user_id) 
  end

end
