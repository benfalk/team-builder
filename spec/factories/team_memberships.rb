# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_membership do
    team_id 1
    user_id 1
    role_id 1
    membership_type "MyString"
  end
end
