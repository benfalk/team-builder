class FixGameStatsData < ActiveRecord::Migration
  def change

    reversible do |dir|
      dir.up do
        GameStats.reset_column_information
        GameStats.where(map_id: nil).all.each do |stats|
          stats.set_fields_from_raw!
          stats.save
        end
      end
    end 

  end
end
