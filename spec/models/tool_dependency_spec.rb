require 'rails_helper'

RSpec.describe ToolDependency, type: :model do
  let(:tool) { FactoryGirl.build(:tool) }
  let(:dependency) {FactoryGirl.build(:tool)}

  context 'creation' do
    subject { FactoryGirl.build(:tool_dependency, tool: tool, dependency: dependency) }
    it { should be_valid }
  end

  context 'validation' do
    subject { FactoryGirl.build(:tool_dependency, tool: tool, dependency: dependency) }

    it { should fail_with_null(:tool) }
    it { should fail_with_null(:dependency) }
    it { should pass_with_null(:note) }
  end
end
