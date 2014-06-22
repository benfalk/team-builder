class CreateEndorsements < ActiveRecord::Migration
  def change
    create_table :endorsements do |t|
      t.integer :user_id
      t.integer :skill_id

      t.timestamps
    end

    add_index :endorsements, [:skill_id,:user_id], name: 'endorsements_user_skill'

  end
end
