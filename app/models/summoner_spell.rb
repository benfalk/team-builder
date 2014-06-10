class SummonerSpell < ActiveRecord::Base
  
  def self.image_url(riot_spell_id)
    @_lookups ||= pluck(:riot_id, :key).to_h
    "https://ddragon.leagueoflegends.com/cdn/4.9.1/img/spell/#{@_lookups[riot_spell_id]}.png"
  end

end
