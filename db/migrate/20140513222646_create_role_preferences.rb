class CreateRolePreferences < ActiveRecord::Migration
  def change
    create_table :role_preferences do |t|
      t.integer :user_id
      t.integer :role_id
      t.string :preference

      t.timestamps
    end
  end
end
