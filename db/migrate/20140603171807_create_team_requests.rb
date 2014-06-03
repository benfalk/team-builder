class CreateTeamRequests < ActiveRecord::Migration
  def change
    create_table :team_requests do |t|
      t.integer :team_id
      t.integer :user_id
      t.text :message
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
