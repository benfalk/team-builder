class GameStats < ActiveRecord::Base
  
  belongs_to :summoner

  serialize :raw, Hash

  class << self
    def update_recent_for(summoner)
      games = LOL::Api::Client.new.game_recent_by_id(summoner.riot_uid)['games']
      games.each do |game|
        game_stats = GameStats.where(riot_game_uid: game['gameId'], summoner_id: summoner.id).first_or_create
        game_stats.update(raw: game)
      end
    end
  end

end
