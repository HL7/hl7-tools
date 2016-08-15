require 'rails_helper'

RSpec.describe PersonOrg, type: :model do
  context 'creation' do
    subject { FactoryGirl.build(:person_org) }
    it { should be_valid }
  end

  context 'validation' do
    subject { FactoryGirl.build(:person_org) }

    it { should fail_with_null(:name) }

    it { should pass_with_null(:contact_phone) }
    it { should pass_with_null(:contact_email) }
    it { should fail_with_null(:is_organization) }
    it { should fail_with_null(:active) }
    it { should pass_with_null(:notes) }

    it { should pass_with_string_at_limit(:contact_phone, 20)}
    it { should fail_with_string_beyond_limit(:contact_phone, 20)}
    it { should pass_with_string_at_limit(:contact_email, 80)}
    it { should fail_with_string_beyond_limit(:contact_email, 80)}
  end
end
