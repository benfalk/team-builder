class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
    
    reversible do |dir|
      dir.up do
        Stream.reset_column_information
        User.all.each do |user|
          user.build_stream
          user.save
        end
        Team.all.each do |team|
          team.build_stream
          team.save
        end
      end
    end

  end
end
