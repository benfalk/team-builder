class PagesController < ApplicationController
  
  def index
    @summoner = Summoner.new
    # The Home Page
  end

end
