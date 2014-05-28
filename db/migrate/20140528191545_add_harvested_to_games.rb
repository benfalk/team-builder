class AddHarvestedToGames < ActiveRecord::Migration
  def change
    add_column :games, :harvested, :boolean, default: false
  end
end
