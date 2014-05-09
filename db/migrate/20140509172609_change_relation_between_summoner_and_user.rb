class ChangeRelationBetweenSummonerAndUser < ActiveRecord::Migration

  def change
    add_column :users, :summoner_id, :integer
    remove_column :summoners, :user_id
  end

end
