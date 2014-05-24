class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :message
      t.string :notification_type
      t.integer :source_id
      t.integer :source_type
      t.integer :stream_id

      t.timestamps
    end
  end
end
