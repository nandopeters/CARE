# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :patient_profile do
    first_name "MyText"
    last_name "MyText"
    cell "MyText"
  end
end
