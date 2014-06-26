class ChampionPreference < ActiveRecord::Base

  delegate :summoner, to: :user

  belongs_to :user

  belongs_to :champion

  def update_played_count!
    update(played_count: GameStats.where(summoner_id: user.summoner_id, played_champion_id: champion_id).count) 
  end

  def percent_of_favorite
    total = user.favorite_champion_preferences.sum(:played_count)

    if total == 0
      0
    else
      ( played_count / total.to_f ).round(4) * 100
    end
  end

end
