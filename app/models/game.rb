class Game < ActiveRecord::Base

  has_and_belongs_to_many :summoners

  has_many :game_stats, class_name: 'GameStats'

  class << self
    
    def from_stats(stats)
      game = Game.where(riot_id: stats.riot_game_uid).first_or_create
      Summoner.harvest_summoners(stats.summoner.region, stats.summoner_riot_ids)
      GameStats.where(riot_game_uid: stats.riot_game_uid).update_all(game_id: game.id)
      game
    end

  end

end
