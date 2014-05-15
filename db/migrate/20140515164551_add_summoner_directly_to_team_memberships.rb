class AddSummonerDirectlyToTeamMemberships < ActiveRecord::Migration
  def change
    add_column :team_memberships, :summoner_id, :integer
  end
end
