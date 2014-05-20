class Champion < ActiveRecord::Base
  
  def avatar_url
    "http://ddragon.leagueoflegends.com/cdn/4.8.2/img/champion/#{key}.png"
  end

end
