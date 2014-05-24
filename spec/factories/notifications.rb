# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    message "MyText"
    notification_type "MyString"
    source_id 1
    source_type 1
    stream_id 1
  end
end
