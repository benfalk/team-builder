# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role_preference do
    user_id 1
    role_id 1
    preference "MyString"
  end
end
