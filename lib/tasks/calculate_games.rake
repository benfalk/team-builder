begin
  namespace :lol do
    namespace :games do
      
      desc 'Calculates Games'
      task :calculate => :environment do
        GameStats.where(game_id: nil).all.each do |stats|
          Game.from_stats(stats)
        end
      end

    end
  end
end
