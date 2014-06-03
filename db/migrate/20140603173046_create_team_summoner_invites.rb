class CreateTeamSummonerInvites < ActiveRecord::Migration
  def change
    create_table :team_summoner_invites do |t|
      t.integer :team_id
      t.integer :summoner_id
      t.integer :status, default: 0
      t.text :message

      t.timestamps
    end
  end
end
