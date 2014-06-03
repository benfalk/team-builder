# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_summoner_invite, :class => 'Team::SummonerInvite' do
    team_id 1
    summoner_id 1
    status 1
  end
end
