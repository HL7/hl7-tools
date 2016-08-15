require 'rails_helper'

RSpec.describe ToolPerson, type: :model do
  let(:tool) { FactoryGirl.build(:tool) }
  let(:person) { FactoryGirl.build(:person_org) }

  context 'creation' do
    subject { FactoryGirl.build(:tool_person, tool: tool, person_org: person) }
    it { should be_valid }
  end

  context 'validation' do
    subject { FactoryGirl.build(:tool_person, tool: tool, person_org: person) }

    it { should fail_with_null(:tool) }
    it { should fail_with_null(:person_org) }
    it { should fail_with_null(:role) }
    it { should fail_with_null(:activity) }
    it { should fail_with_non_numeric(:activity) }
    it { should pass_with_null(:notes) }
    it { should fail_with_null(:updated_at) }

    it 'should validate the role codes' do
      expect(FactoryGirl.build(:tool_person, tool: tool, person_org: person,
                               role: ['dev'])).to be_valid
      expect(FactoryGirl.build(:tool_person, tool: tool, person_org: person,
                               role: ['dev', 'maint'])).to be_valid

      expect(FactoryGirl.build(:tool_person, tool: tool, person_org: person,
                               role: ['dev', 'maint', 'fred'])).not_to be_valid

      expect(FactoryGirl.build(:tool_person, tool: tool, person_org: person,
                               role: ['fred'])).not_to be_valid
      object = FactoryGirl.build(:tool_person, tool: tool, person_org: person, role: ['fred'])
      object.valid?
      expect(object.errors[:role].count).to be > 0
    end
  end

  it 'should validate removing blank role codes'
  it 'should validate the activity range'
end
