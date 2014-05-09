class CreateSummonerStatsSummaries < ActiveRecord::Migration
  def change
    create_table :summoner_stats_summaries do |t|
      t.integer :summoner_id
      t.text :raw

      t.timestamps
    end
  end
end
