# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_note do
    note "MyText"
    league_replay "MyString"
    team_id 1
    game_id 1
  end
end
