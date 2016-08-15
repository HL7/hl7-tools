require "rails_helper"

RSpec.describe PersonOrgsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/person_orgs').to route_to('person_orgs#index')
    end

    it 'routes to #new' do
      expect(:get => '/person_orgs/new').to route_to('person_orgs#new')
    end

    it 'routes to #show' do
      expect(:get => '/person_orgs/1').to route_to('person_orgs#show', :id => '1')
    end

    it 'routes to #edit' do
      expect(:get => '/person_orgs/1/edit').to route_to('person_orgs#edit', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/person_orgs').to route_to('person_orgs#create')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/person_orgs/1').to route_to('person_orgs#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/person_orgs/1').to route_to('person_orgs#update', :id => '1')
    end
  end
end
