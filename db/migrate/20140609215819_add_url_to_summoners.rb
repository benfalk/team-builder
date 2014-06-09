class AddUrlToSummoners < ActiveRecord::Migration
  def change
    add_column :summoners, :url, :string
    add_index :summoners, [:url], unique: true

    reversible do |dir|
      dir.up do
        Summoner.reset_column_information
        Summoner.where(url: nil).find_in_batches(batch_size: 30) do |summoners|
          summoners.each do |s|
            s.update(url: s.valid_slug_name)
          end
        end
      end
    end 

  end
end
