require 'rails_helper'

RSpec.describe 'tool_assessments/new', type: :view do
  before(:each) do
    @tool = assign(:tool, FactoryGirl.create(:tool))
    assign(:tool_assessment, ToolAssessment.new())
  end

  it 'renders new tool_assessment form' do
    render

    assert_select 'form[action=?][method=?]', tool_tool_assessments_path(@tool), 'post' do
    end
  end
end
