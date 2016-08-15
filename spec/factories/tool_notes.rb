FactoryGirl.define do
  factory :tool_note do
    tool       nil
    note      'lorem ipsum'
    note_date Date.today
  end
end
