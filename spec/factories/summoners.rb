# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :summoner do
    region "MyString"
    name "MyString"
    verified false
    user_id 1
  end
end
