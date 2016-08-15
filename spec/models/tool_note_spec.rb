require 'rails_helper'

RSpec.describe ToolNote, type: :model do
  let(:tool) { FactoryGirl.build(:tool) }

  context 'creation' do
    subject { FactoryGirl.build(:tool_note, tool: tool) }
    it { should be_valid }
  end

  context 'validation' do
    subject { FactoryGirl.build(:tool_note, tool: tool) }

    it { should fail_with_null(:tool) }
    it { should fail_with_null(:note) }
    it { should fail_with_null(:note_date) }
    it { should pass_with_null(:author) }
    it { should fail_with_string_beyond_limit(:author, 60)}
  end
end
