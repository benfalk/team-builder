class AddGameModeToGameStats < ActiveRecord::Migration

  def change
    add_column :game_stats, :game_mode, :string

    reversible do |dir|
      dir.up do
        GameStats.reset_column_information
        GameStats.all.each do |stats|
          stats.update(game_mode: stats.raw['gameMode']) 
        end
      end
    end 

  end
end
