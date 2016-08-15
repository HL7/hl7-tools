require 'rails_helper'

RSpec.describe ToolAssessment, type: :model do
  let(:tool) { FactoryGirl.build(:tool) }

  context 'creation' do
    subject { FactoryGirl.build(:tool_assessment, tool: tool) }
    it { should be_valid }
  end

  context 'validation' do
    subject { FactoryGirl.build(:tool_assessment, tool: tool) }

    it { should fail_with_null(:tool) }
    it { should fail_with_null(:assessment_date) }
    it { should fail_with_null(:required) }
    it { should fail_with_null(:risk) }
    it { should fail_with_non_numeric(:risk) }
    it { should fail_with_null(:quality) }
    it { should fail_with_non_numeric(:quality) }
    it { should fail_with_null(:sustainability) }
    it { should fail_with_non_numeric(:sustainability) }
    it { should fail_with_null(:usability) }
    it { should fail_with_non_numeric(:usability) }
    it { should pass_with_null(:note) }

    it 'should check risk range'
    it 'should check quality range'
    it 'should check sustainability range'
    it 'should check usability range'
  end
end
