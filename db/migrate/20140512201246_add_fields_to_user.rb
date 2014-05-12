class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :short_bio, :text
    add_column :users, :location_city, :string
    add_column :users, :location_state, :string
    add_column :users, :play_style, :string
    add_column :users, :gaming_times, :string
  end
end
