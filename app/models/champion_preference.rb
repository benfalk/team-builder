class ChampionPreference < ActiveRecord::Base

  delegate :summoner, to: :user

  belongs_to :user

  belongs_to :champion

  def update_played_count!
    update(played_count: GameStats.where(summoner_id: user.summoner_id, played_champion_id: champion_id).count) 
  end

end
