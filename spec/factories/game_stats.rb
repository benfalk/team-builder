# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_stat, :class => 'GameStats' do
    summoner_id 1
    riot_uid ""
    raw "MyText"
  end
end
