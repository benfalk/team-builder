begin
  namespace :db do
    namespace :summoner_spells do

      desc 'Sync the summoner spells from LOL database'
      task sync: :environment do
        LOL::Api::Client.new.summoner_spells['data'].each_pair do |key,data|
          spell = SummonerSpell.where(riot_id: data['id']).first_or_create
          spell.update(key: data['key'], description: data['description'])
        end
      end

    end
  end
end
