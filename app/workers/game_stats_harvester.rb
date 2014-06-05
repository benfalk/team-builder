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
        summoners = Summoner.where(id: game.missing_summoner_id_stats)
        summoners.each do |summoner|
          GameStats.update_recent_for(summoner)
          sleep(3)
        end
        GameStats.where(game_id: nil, riot_game_uid: game.riot_id).update_all(game_id: game.id)
        game.update(harvested: true)
        begin
          team.stream.parse_game_notifications(game)
        rescue
          nil
        end
      end
    end

    Summoner.actively_tracked.all.each do |s|
      s.calculate_agpm!
    end

  end

end
