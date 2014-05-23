class AddPlayedAtFieldToGameStats < ActiveRecord::Migration
  def change

    add_column :game_stats, :played_at, :datetime

    reversible do |dir|
      dir.up do
        GameStats.reset_column_information
        GameStats.all.each do |stats|
          stats.determine_played_at
          stats.save
        end
      end
    end

  end
end
