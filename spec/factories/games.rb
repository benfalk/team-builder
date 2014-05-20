# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    riot_id 1
    game_mode "MyString"
    game_stype "MyString"
    sub_type "MyString"
    played_at "2014-05-20 13:58:33"
    team_id 1
    notes "MyText"
  end
end
