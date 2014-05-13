class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :map
      t.string :name

      t.timestamps
    end
  end
end
