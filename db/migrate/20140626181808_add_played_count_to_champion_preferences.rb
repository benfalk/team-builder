class AddPlayedCountToChampionPreferences < ActiveRecord::Migration
  def change
    add_column :champion_preferences, :played_count, :integer, default: 0
  end
end
