class GameStatsHarvester

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily.hour_of_day(0,2,4,6,8,10,12,14,16,18,20,22) }

  def perform

    User.all.each do |u|
      GameStats.update_recent_for(u.summoner)
      u.summoner.game_stats.where(game_id: nil).all.each do |stats|
        Game.from_stats(stats)
      end
      sleep 2
    end

  end

end
