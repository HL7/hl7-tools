require 'rails_helper'

RSpec.describe ToolUser, type: :model do
  let(:tool) { FactoryGirl.build(:tool) }

  context 'creation' do
    subject { FactoryGirl.build(:tool_user, tool: tool) }
    it { should be_valid }
  end

  context 'validation' do
    subject { FactoryGirl.build(:tool_user, tool: tool) }

    it { should fail_with_null(:tool) }

    it 'should require at least one of work_group_id, organization_name external_list' do
      expect(FactoryGirl.build(:tool_user, tool: tool, organization_name: nil,
                               external_list: 'x', work_group_id: nil)).to be_valid
      expect(FactoryGirl.build(:tool_user, tool: tool, organization_name: nil,
                               external_list: nil, work_group_id: 23)).to be_valid
      expect(FactoryGirl.build(:tool_user, tool: tool, organization_name: 'Evil Corp',
                               external_list: nil, work_group_id: nil)).to be_valid

      expect(FactoryGirl.build(:tool_user, tool: tool, organization_name: nil,
                               external_list: nil, work_group_id: nil)).not_to be_valid
    end

    it 'should limit to only one of work_group_id, organization_name external_list'
  end
end
