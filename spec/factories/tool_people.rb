FactoryGirl.define do
  factory :tool_person do
    tool nil
    person_org nil
    role ['dev']
    activity 5
    updated_at Date.today
  end
end
