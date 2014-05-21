class Champion < ActiveRecord::Base
  
  class << self
    
    def convert_riot_id(id)
      @_lookup ||= Champion.pluck(:riot_id,:id).to_h
      @_lookup[id.to_i]
    end

  end

  def avatar_url
    "http://ddragon.leagueoflegends.com/cdn/4.8.2/img/champion/#{key}.png"
  end

end
