class AddAgpmToSummoners < ActiveRecord::Migration
  def change
    add_column :summoners, :agpm, :integer, default: 0
  end
end
