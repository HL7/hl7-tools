require 'rails_helper'

RSpec.describe ToolPeopleController, type: :routing do
  describe 'routing' do

    it 'routes to #new' do
      expect(:get => '/tools/1/tool_people/new').to route_to('tool_people#new',tool_id: '1')
    end

    it 'routes to #edit' do
      expect(:get => '/tool_people/1/edit').to route_to('tool_people#edit', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/tools/1/tool_people').to route_to('tool_people#create',tool_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/tools/1/tool_people/1').to route_to('tool_people#update',tool_id: '1', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/tools/1/tool_people/1').to route_to('tool_people#update',tool_id: '1', :id => '1')
    end
  end
end
