class AddTwitchToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitch_name, :string
  end
end
