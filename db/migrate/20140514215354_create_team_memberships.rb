class CreateTeamMemberships < ActiveRecord::Migration
  def change
    create_table :team_memberships do |t|
      t.integer :team_id
      t.integer :user_id
      t.integer :role_id
      t.string :membership_type

      t.timestamps
    end
  end
end
