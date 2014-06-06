class AddGamingTimesToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :gaming_times, :string

    reversible do |dir|
      dir.up do
        Team.reset_column_information
        Team.all.each do |t|
          gaming_time = t.users.first.try(:gaming_times)
          t.update gaming_times: gaming_time
        end
      end
    end 

  end
end
