class Reaper

  include Sidekiq::Worker

  def perform

    last = Summoner.last.id

    puts "Reaping Summoners..."
    Summoner.where('id < ?', last+1).find_in_batches(batch_size: 40).with_index do |summoners,idx|
      
      puts "Processing Summoner batch ##{idx+1}..."
      summoners.each do |summoner|

        puts "\tFetching new games for summoner #{summoner.name}"
        GameStats.update_recent_for(summoner)
        sleep 1 if Rails.env.development?

        puts "\t\tfolding in summoners..."
        summoner.game_stats.where(game_id: nil).find_in_batches(batch_size: 4).with_index do |stats,idx|
          Summoner.harvest_summoners(summoner.region, stats.map(&:summoner_riot_ids).flatten)
          stats.each { |s| Game.from_stats(s) }
        end

      end

      sleep 2

    end


  end

end
