class AddFromToNotifications < ActiveRecord::Migration
  def change
    
    add_column :notifications, :from, :string, default: ''
    change_column :notifications, :source_type, :string

    reversible do |dir|
      dir.up do
        Notification.reset_column_information
        Notification.where(source_type: '0').update_all(source_type:'User')
        Notification.all.each do |n|
          n.determine_from_field
          n.save
        end
      end
    end 

  end
end
