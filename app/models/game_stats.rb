class GameStats < ActiveRecord::Base
  
  include GoldPerMinuteCalculations

  MAP_NAMES = {
    1 => "Summoner's Rift",
    2 => "Summoner's Rift",
    3 => "The Proving Grounds",
    4 => "Twisted Treeline",
    8 => "The Crystal Scar",
    10 => "Twisted Treeline",
    12 => "Howling Abyss"
  }
  
  belongs_to :summoner

  belongs_to :played_champion, class_name: 'Champion', foreign_key: :played_champion_id

  belongs_to :game

  scope :summoners_rift, ->{ where(map_id:[1,2]) }

  serialize :raw, Hash

  scope :non_bot_matches, ->{ where.not(sub_type: ['BOT','BOT_3x3','URF_BOT']) }

  scope :gold_per_minute_matches, ->{ non_bot_matches.summoners_rift.where.not(gold_per_minute: nil) }

  class << self

    def update_recent_for(summoner)
      games = LOL::Api::Client.new(region: summoner.region).game_recent_by_id(summoner.riot_uid)['games']
      games.each do |game|
        game_stats = GameStats.where(riot_game_uid: game['gameId'], summoner_id: summoner.id).first_or_create
        game_stats.raw = game
        game_stats.played_champion_id = Champion.convert_riot_id(game['championId'])
        game_stats.set_fields_from_raw!
        game_stats.determine_played_at
        game_stats.calculate_gold_per_minute
        game_stats.save
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

  def determine_played_at
   self.played_at = played_at
  end

  def set_fields_from_raw!
    self.game_type = raw['gameType']
    self.sub_type = raw['subType']
    self.game_mode = raw['gameMode']
    self.map_id = raw['mapId']
  end

  def won?
    raw['stats']['win']
  end

  def quadra_kills?
    multikill_for? 'quadraKills'
  end

  def penta_kills?
    multikill_for? 'pentaKills'
  end

  def triple_kills?
    multikill_for? 'tripleKills'
  end

  def raw_stats?
    raw && raw['stats']
  end

  def played_at
    super || Time.at(raw['createDate']/1000).to_datetime
  end

  def summoner_riot_ids
    if raw['fellowPlayers']
      raw['fellowPlayers'].map { |p| p['summonerId'] }
    else
      []
    end
  end

  def map_name
    MAP_NAMES.fetch(map_id){ 'Unkown' }
  end

  def calculate_gold_per_minute
    self.gold_per_minute = ( raw['stats']['goldEarned'] / duration_in_minutes ).floor
  end

  def duration_in_minutes
    ( raw['stats']['timePlayed'] / 60.0 ).round(2)
  end

  def kda
    "#{raw['stats']['championsKilled']}/#{raw['stats']['numDeaths']}/#{raw['stats']['assists']}"
  end

  private

  def multikill_for?(name)
    raw_stats? && raw['stats'][name] && raw['stats'][name] > 0
  end

end
