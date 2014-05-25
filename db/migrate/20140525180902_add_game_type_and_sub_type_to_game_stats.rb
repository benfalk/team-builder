class AddGameTypeAndSubTypeToGameStats < ActiveRecord::Migration
  def change
    add_column :game_stats, :game_type, :string
    add_column :game_stats, :sub_type, :string

    reversible do |dir|
      dir.up do
        GameStats.reset_column_information
        GameStats.all.each do |stats|
          stats.update(
            game_type: stats.raw['gameType'],
            sub_type: stats.raw['subType']
          ) 
        end
      end
    end 

  end
end
