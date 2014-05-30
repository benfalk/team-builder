class Team::GoldPerMinuteGames
  
  attr_reader :team
  
  def initialize(team)
    @team = team
  end

  def call
    summoners.map do |key,data|
      {
        summoner: data,
        games: last_ten(key)
      }
    end
  end

  private

  def summoner_ids
    @summoner_ids ||= team.team_memberships.pluck(:summoner_id).freeze
  end

  def summoners
    @summoners ||= Summoner.where(id: summoner_ids).pluck(:id, :name).to_h
  end

  def last_ten(id)
    GameStats.gold_per_minute_matches.where(summoner_id: id).order(played_at: :desc).limit(10).pluck(:gold_per_minute).reverse
  end

end
