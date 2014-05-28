class GameStatsHarvester

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily.hour_of_day(0,2,4,6,8,10,12,14,16,18,20,22) }

  def perform

    puts "Updating Users..."
    User.all.each do |u|
      GameStats.update_recent_for(u.summoner)
      u.summoner.game_stats.where(game_id: nil).all.each do |stats|
        Game.from_stats(stats)
      end
      sleep 2
    end

    Team.all.each do |team|
      games = team.games.where(harvested: false, played_at:(2.days.ago..1.minute.from_now))
      puts "Doing team #{team.name}... they have #{games.count}"
      games.each do |game|
        puts "Doing game #{game}"
        if game.summoners.any?
          game.summoners.each do |s|
            GameStats.update_recent_for(s)
            sleep(2)
            s.game_stats.where(game_id: nil).all.each do |s|
              Game.from_stats(s)
            end
          end
        end
        game.update(harvested: true)
      end
    end

  end

end
