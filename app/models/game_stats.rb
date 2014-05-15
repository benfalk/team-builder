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

    def top_played_with
      counts = {}
      all.to_a.each do |game|
        team = game.raw['teamId']
        game.raw['fellowPlayers'].each do |player|
          if player['teamId'] == team
            counts[player['summonerId']] ||= 0
            counts[player['summonerId']] += 1
          end
        end
      end
      counts
    end

  end

end
