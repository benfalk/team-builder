class CalculateAgpmForSummoners < ActiveRecord::Migration
  def change

    reversible do |dir|
      dir.up do
        Summoner.reset_column_information
        Summoner.actively_tracked.all.each do |s|
          s.calculate_agpm!
        end
      end
    end 

  end
end
