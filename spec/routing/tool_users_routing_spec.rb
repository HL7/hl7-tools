require 'rails_helper'

RSpec.describe ToolUsersController, type: :routing do
  describe 'routing' do

    it 'routes to #new' do
      expect(:get => '/tools/1/tool_users/new').to route_to('tool_users#new', tool_id: '1')
    end

    it 'routes to #edit' do
      expect(:get => '/tool_users/1/edit').to route_to('tool_users#edit', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/tools/1/tool_users').to route_to('tool_users#create', tool_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/tools/1/tool_users/1').to route_to('tool_users#update', tool_id: '1', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/tools/1/tool_users/1').to route_to('tool_users#update', tool_id: '1', :id => '1')
    end
  end
end
