class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.integer :user_id
      t.string :title

      t.timestamps
    end

    add_index :skills, [:user_id]
  end
end
