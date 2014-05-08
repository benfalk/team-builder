class AddRiotUidToSummoner < ActiveRecord::Migration
  def change
    add_column :summoners, :riot_uid, :integer
  end
end
