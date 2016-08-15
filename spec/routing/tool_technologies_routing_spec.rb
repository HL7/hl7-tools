require 'rails_helper'

RSpec.describe ToolTechnologiesController, type: :routing do
  describe 'routing' do

    it 'routes to #new' do
      expect(:get => '/tools/1/tool_technologies/new').to route_to('tool_technologies#new', tool_id: '1')
    end

    it 'routes to #edit' do
      expect(:get => '/tool_technologies/1/edit').to route_to('tool_technologies#edit', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/tools/1/tool_technologies').to route_to('tool_technologies#create', tool_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/tools/1/tool_technologies/1').to route_to('tool_technologies#update', tool_id: '1', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/tools/1/tool_technologies/1').to route_to('tool_technologies#update', tool_id: '1', :id => '1')
    end
  end
end
