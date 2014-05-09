class CreateGameStats < ActiveRecord::Migration
  def change
    create_table :game_stats do |t|
      t.integer :summoner_id
      t.integer :riot_game_uid
      t.text :raw

      t.timestamps
    end
  end
end
