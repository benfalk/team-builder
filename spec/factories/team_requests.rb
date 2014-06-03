# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_request, :class => 'Team::Request' do
    team_id 1
    user_id 1
    message "MyText"
  end
end
