class CreateSummonerSpells < ActiveRecord::Migration
  def change
    create_table :summoner_spells do |t|
      t.integer :riot_id
      t.string :key
      t.text :description

      t.timestamps
    end
  end
end
