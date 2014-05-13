class CreateChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|
      t.string :name
      t.string :title
      t.integer :riot_id
      t.string :key

      t.timestamps
    end
  end
end
