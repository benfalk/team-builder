class AddIndexToSubType < ActiveRecord::Migration
  def change
    add_index :game_stats, [:sub_type]
  end
end
