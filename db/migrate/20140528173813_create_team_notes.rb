class CreateTeamNotes < ActiveRecord::Migration
  def change
    create_table :team_notes do |t|
      t.text :note
      t.string :league_replay
      t.integer :team_id
      t.integer :game_id

      t.timestamps
    end
  end
end
