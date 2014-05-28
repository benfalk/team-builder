class AddGoldPerMinuteToGameStats < ActiveRecord::Migration
  def change
    add_column :game_stats, :gold_per_minute, :integer, default: 0

    reversible do |dir|
      dir.up do
        GameStats.reset_column_information
        GameStats.all.each do |g|
          g.calculate_gold_per_minute
          g.save
        end
      end
    end 

  end
end
