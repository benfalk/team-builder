class AddMapIdToStats < ActiveRecord::Migration
  def change
  
    add_column :game_stats, :map_id, :integer

    reversible do |dir|
      dir.up do
        GameStats.reset_column_information
        GameStats.all.each do |stats|
          stats.update(map_id: stats.raw['mapId'])
        end
      end
    end 

  end
end
