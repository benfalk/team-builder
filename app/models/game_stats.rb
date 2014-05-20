class GameStats < ActiveRecord::Base
  
  belongs_to :summoner

  belongs_to :played_champion, class_name: 'Champion', foreign_key: :played_champion_id

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

    def determine_played_champions
      games = where(played_champion_id:nil).to_a
      champ_riot_ids = games.map { |g| g.raw['championId'] }
      champs = Champion.where(riot_id: champ_riot_ids).to_a
      games.each do |game|
        champs.find { |c| c.riot_id == game.raw['championId'] }.tap do |champ|
          game.update(played_champion_id: champ.id) if champ
        end
      end
    end

  end

  def won?
    raw['stats']['win']
  end

  def played_at
    Time.at(raw['createDate']/1000).to_datetime
  end

end
