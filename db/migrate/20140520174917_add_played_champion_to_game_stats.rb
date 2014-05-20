class AddPlayedChampionToGameStats < ActiveRecord::Migration
  def change
    add_column :game_stats, :played_champion_id, :integer
  end
end
