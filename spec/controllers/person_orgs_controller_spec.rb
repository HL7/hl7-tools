require 'rails_helper'

RSpec.describe PersonOrgsController, type: :controller do
  let(:valid_session) { {} }

  context 'in admin mode' do
    around(:example) do |example|
      ENV['HL7_TOOL_EDITING'] = 'TRUE'
      example.run
      ENV.delete('HL7_TOOL_EDITING')
    end

    describe 'GET #index' do
      it 'assigns all person_orgs as @person_orgs' do
        person_org = FactoryGirl.create(:person_org)
        get :index, {}, valid_session
        expect(assigns(:person_orgs)).to eq([person_org])
      end
    end

    describe 'GET #show' do
      it 'assigns the requested person_org as @person_org' do
        person_org = FactoryGirl.create(:person_org)
        get :show, {:id => person_org.to_param}, valid_session
        expect(assigns(:person_org)).to eq(person_org)
      end
    end

    describe 'GET #new' do
      it 'assigns a new person_org as @person_org' do
        get :new, {}, valid_session
        expect(assigns(:person_org)).to be_a_new(PersonOrg)
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested person_org as @person_org' do
        person_org = FactoryGirl.create(:person_org)
        get :edit, {:id => person_org.to_param}, valid_session
        expect(assigns(:person_org)).to eq(person_org)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        let(:valid_attributes) { FactoryGirl.attributes_for(:person_org) }

        it 'creates a new PersonOrg' do
          expect {
            post :create, {:person_org => valid_attributes}, valid_session
          }.to change(PersonOrg, :count).by(1)
        end

        it 'assigns a newly created person_org as @person_org' do
          post :create, {:person_org => valid_attributes}, valid_session
          expect(assigns(:person_org)).to be_a(PersonOrg)
          expect(assigns(:person_org)).to be_persisted
        end

        it 'redirects to the created person_org' do
          post :create, {:person_org => valid_attributes}, valid_session
          expect(response).to redirect_to(PersonOrg.last)
        end
      end

      context 'with invalid params' do
        let(:invalid_attributes) { FactoryGirl.attributes_for(:person_org, name: nil) }

        it 'assigns a newly created but unsaved person_org as @person_org' do
          post :create, {:person_org => invalid_attributes}, valid_session
          expect(assigns(:person_org)).to be_a_new(PersonOrg)
        end

        it 're-renders the new template' do
          post :create, {:person_org => invalid_attributes}, valid_session
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) { { name: 'Fred'} }

        it 'updates the requested person_org' do
          person_org = FactoryGirl.create(:person_org)
          put :update, {:id => person_org.to_param, :person_org => new_attributes}, valid_session
          person_org.reload
          expect(person_org.name).to eq 'Fred'
        end

        it 'assigns the requested person_org as @person_org' do
          person_org = FactoryGirl.create(:person_org)
          put :update, {:id => person_org.to_param, :person_org => new_attributes}, valid_session
          expect(assigns(:person_org)).to eq(person_org)
        end

        it 'redirects to the person_org' do
          person_org = FactoryGirl.create(:person_org)
          put :update, {:id => person_org.to_param, :person_org => new_attributes}, valid_session
          expect(response).to redirect_to(person_org)
        end
      end

      context 'with invalid params' do
        let(:invalid_attributes) { { name: nil} }

        it 'assigns the person_org as @person_org' do
          person_org = FactoryGirl.create(:person_org)
          put :update, {:id => person_org.to_param, :person_org => invalid_attributes}, valid_session
          expect(assigns(:person_org)).to eq(person_org)
        end

        it 're-renders the edit template' do
          person_org = FactoryGirl.create(:person_org)
          put :update, {:id => person_org.to_param, :person_org => invalid_attributes}, valid_session
          expect(response).to render_template(:edit)
        end
      end
    end
  end
end
