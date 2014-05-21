class GameBuilder

  include Sidekiq::Worker

  def perform(summoner_id)
    summoner = Summoner.find(summoner_id)
    if summoner
      summoner.game_stats.where(game_id: nil).all.each do |stats|
        Game.from_stats(stats)
      end
    end
  end

end
