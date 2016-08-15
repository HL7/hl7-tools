FactoryGirl.define do
  factory :tool do
    name 'MyString'
    description 'MyString'
    purpose 'MyString'
    url 'http://somewhere.org/x'
    internal false
    version 'MyString'
    rollout_date '2016-05-12'
    last_update_date '2016-05-20'

    factory :cucumber_sample_tool do
      name            'Sample Tool 1'
      description     'A sample tool description'
      support_url     'http://somewhere.org/track'
      version         'alpha'
      product         ['FHIR', 'V2']
      functional_area ['educate', 'impl']

      after(:create) do |tool, evaluator|
        create(:tool_technology, tool: tool, technology: 'java', tech_version: 'v1.8')
        create(:tool_note, tool: tool, note: 'Sample note 1', author: 'tester',
               note_date: Date.today - 1)
        create(:tool_note, tool: tool, note: 'Sample note 2', author: 'tester',
               note_date: Date.today)
        create(:tool_person, tool: tool, role: ['dev'],
               person_org: create(:person_org, name: 'Joe Hacker', contact_phone: '+1 780-903-0885'))
        create(:tool_person, tool: tool, role: 'admin',
               person_org: create(:person_org, name: 'Somewhere Hospital',
                                  contact_email: 'someone@somewhere.com'))
        create(:tool_dependency, tool: tool, dependency: create(:tool, name: 'Core Tool'))
        create(:tool_user, tool: tool, organization_name: 'FDA')
        create(:tool_assessment, tool: tool)
      end
    end
  end
end
