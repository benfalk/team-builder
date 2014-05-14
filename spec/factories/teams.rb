# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    name "MyString"
    about_us "MyText"
    avatar "MyString"
    game_style "MyString"
    region "MyString"
  end
end
