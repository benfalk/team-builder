class AddGenderAndFacebookToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :integer, default: 0
    add_column :users, :facebook_id, :string

    add_column :users, :birthday, :date
  end
end
