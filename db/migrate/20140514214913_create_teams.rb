class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.text :about_us
      t.string :avatar
      t.string :play_style
      t.string :region

      t.timestamps
    end
  end
end
