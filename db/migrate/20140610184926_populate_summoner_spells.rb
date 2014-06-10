class PopulateSummonerSpells < ActiveRecord::Migration
  def change

    reversible do |dir|
      dir.up do
        SummonerSpell.reset_column_information
        LOL::Api::Client.new.summoner_spells['data'].each_pair do |key,data|
          spell = SummonerSpell.where(riot_id: data['id']).first_or_create
          spell.update(key: data['key'], description: data['description'])
        end
      end
    end 

  end
end
