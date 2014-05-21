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

  def bind_to_summoners
    stats = game_stats.first
    ids = stats.summoner_riot_ids + [stats.summoner.riot_uid]
    self.summoner_ids = Summoner.where(riot_uid: ids).pluck(:id)
  end

  def overview
    @_overview ||= begin
      players = all_players.sort_by { |p| p['teamId'] }
      _summoners = summoners
      _stats = game_stats
      players.each do |player|
        player['stats'] = _stats.find{|s| player['summonerId'] == s.summoner.riot_uid}
        player['champion'] = champions.find{|c| c.riot_id == player['championId']}
        player['summoner'] = _summoners.find{|s| s.riot_uid == player['summonerId']}
      end
    end
  end

  def top_team
    overview.select{|o| o['teamId'] == 200}
  end
  
  def bottom_team
    overview.select{|o| o['teamId'] == 100}
  end

  def all_players
    @all_players ||= begin
      first_game_stats.raw['fellowPlayers'].tap do |p|
        p << { 
          'summonerId' => first_game_stats.summoner.riot_uid,
          'teamId' => first_game_stats.raw['teamId'],
          'championId' => first_game_stats.raw['championId']
        }
      end
    end
  end

  def champions
    @champions ||= Champion.where(riot_id: all_players.map{|p| p['championId']}).to_a
  end

  private

  def first_game_stats
    @_stats ||= game_stats.first
  end

end
