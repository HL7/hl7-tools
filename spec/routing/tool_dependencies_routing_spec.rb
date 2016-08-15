require 'rails_helper'

RSpec.describe ToolDependenciesController, type: :routing do
  describe 'routing' do

    it 'routes to #new' do
      expect(:get => '/tools/1/tool_dependencies/new').to route_to('tool_dependencies#new', tool_id: '1')
    end

    it 'routes to #edit' do
      expect(:get => '/tool_dependencies/1/edit').to route_to('tool_dependencies#edit', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/tools/1/tool_dependencies').to route_to('tool_dependencies#create', tool_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/tools/1/tool_dependencies/1').to route_to('tool_dependencies#update', tool_id: '1', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/tools/1/tool_dependencies/1').to route_to('tool_dependencies#update', tool_id: '1', :id => '1')
    end
  end
end
