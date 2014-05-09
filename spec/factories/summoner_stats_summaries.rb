# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :summoner_stats_summary, :class => 'Summoner::StatsSummary' do
    summoner_id 1
    raw "MyText"
  end
end
