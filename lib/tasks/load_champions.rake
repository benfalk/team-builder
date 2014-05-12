begin
  namespace :db do
    namespace :champion do
      
      desc 'Sync the champions for LOL database'
      task :sync => :environment do
        LOL::Api::Client.new.champions['data'].each_pair do |name,data|
          champ = Champion.where(name: name).first_or_create
          champ.update(key: data['key'], title: data['title'], riot_id: data['id'])
        end
      end

    end
  end
end
