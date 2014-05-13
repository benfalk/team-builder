# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :champion_preference do
    user_id 1
    champion_id 1
    preference "MyString"
  end
end
