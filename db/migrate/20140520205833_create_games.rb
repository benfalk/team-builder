class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :riot_id
      t.string :game_mode
      t.string :game_stype
      t.string :sub_type
      t.datetime :played_at

      t.timestamps
    end

    create_table :games_summoners, id: false do |t|
      t.integer :summoner_id
      t.integer :game_id
    end

    add_index :games_summoners, [:summoner_id, :game_id], unique: true

  end
end
