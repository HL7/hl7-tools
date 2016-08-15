require 'rails_helper'

RSpec.describe ToolNotesController, type: :routing do
  describe 'routing' do

    it 'routes to #new' do
      expect(:get => '/tools/1/tool_notes/new').to route_to('tool_notes#new',tool_id: '1')
    end

    it 'routes to #edit' do
      expect(:get => '/tool_notes/1/edit').to route_to('tool_notes#edit', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/tools/1/tool_notes').to route_to('tool_notes#create',tool_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/tools/1/tool_notes/1').to route_to('tool_notes#update',tool_id: '1', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/tools/1/tool_notes/1').to route_to('tool_notes#update',tool_id: '1', :id => '1')
    end
  end
end
