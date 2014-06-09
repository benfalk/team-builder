class FixTeamRegions < ActiveRecord::Migration
  def change
    Team.all.each do |t|
      t.send(:assign_region)
    end
  end
end
