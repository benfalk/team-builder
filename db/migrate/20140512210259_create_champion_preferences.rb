class CreateChampionPreferences < ActiveRecord::Migration
  def change
    create_table :champion_preferences do |t|
      t.integer :user_id
      t.integer :champion_id
      t.string :preference

      t.timestamps
    end
  end
end
