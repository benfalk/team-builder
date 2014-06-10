# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :summoner_spell do
    riot_id 1
    key "MyString"
    description "MyText"
  end
end
