FactoryGirl.define do
  factory :tool_assessment do
    tool nil
    assessment_date { Date.today.strftime('%Y-%m-%d') }
    required        true
    risk            25
    quality         50
    sustainability  75
    usability       100
  end
end
