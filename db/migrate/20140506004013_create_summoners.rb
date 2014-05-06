class CreateSummoners < ActiveRecord::Migration
  def change
    create_table :summoners do |t|
      t.string :region
      t.string :name
      t.integer :level
      t.boolean :verified, default: false
      t.string :verify_string
      t.integer :user_id

      t.timestamps
    end

    add_index :summoners, [:region, :name], unique: true
  end
end
