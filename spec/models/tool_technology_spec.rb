require 'rails_helper'

RSpec.describe ToolTechnology, type: :model do
  let(:tool) { FactoryGirl.build(:tool) }

  context 'creation' do
    subject { FactoryGirl.build(:tool_technology, tool: tool) }
    it { should be_valid }
  end

  context 'validation' do
    subject { FactoryGirl.build(:tool_technology, tool: tool) }

    it { should fail_with_null(:tool) }
    it { should fail_with_null(:technology) }
    it { should pass_with_null(:tech_version) }
    it { should pass_with_null(:note) }
    it { should fail_with_string_beyond_limit(:tech_version, 30)}

    it 'should validate the technology code' do
      expect(FactoryGirl.build(:tool_technology, tool: tool, technology: 'ruby')).to be_valid

      expect(FactoryGirl.build(:tool_technology, tool: tool, technology: 'fred')).not_to be_valid
      object = FactoryGirl.build(:tool_technology, tool: tool, technology: 'fred')
      object.valid?
      expect(object.errors[:technology].count).to be > 0
    end
  end

  context 'run-time' do
    it 'should work with invalid technology'
  end
end
