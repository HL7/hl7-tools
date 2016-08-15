require 'rails_helper'

RSpec.describe ToolAssessmentsController, type: :routing do
  describe 'routing' do

    it 'routes to #new' do
      expect(:get => '/tools/1/tool_assessments/new').to route_to('tool_assessments#new', tool_id: '1')
    end

    it 'routes to #create' do
      expect(:post => '/tools/1/tool_assessments').to route_to('tool_assessments#create', tool_id: '1')
    end
  end
end
