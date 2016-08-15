FactoryGirl.define do
  factory :person_org do
    name            'Joe Hack'
    contact_email   'joe.hack@gmail.com'
    is_organization false
    active          true
  end
end
