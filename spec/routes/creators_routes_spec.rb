require_relative '../spec_helper'
require_relative '../../app/models/creator'

describe 'API - Creators' do
  include Rack::Test::Methods

  let(:creator_params) { { first_name: 'Peter', last_name: 'Parker' } }

  before(:each) do
    CreatorRole.all.destroy
    Creator.all.destroy
  end

  def app
    LongboxApi
  end

  describe 'GET /api/creators' do
    it 'should get all creators' do
      Creator.create(creator_params)

      get '/api/creators'
      expect(last_response).to be_ok
    end
  end

  describe 'GET /api/creators/:id' do
    it 'should display a specific creator' do
      creator = Creator.create(creator_params)

      get "/api/creators/#{creator.id}"
      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response['first_name']).to eq('Peter')
    end
  end

  describe 'POST /api/creators' do
    it 'should insert the creator into the database' do
      expect { post '/api/creators', creator_params.to_json }
        .to change { Creator.count }.by(1)

      expect(last_response.status).to eq(201)
    end
  end

  describe 'PUT /api/creators/:id' do
    it 'should insert the creator into the database' do
      creator = Creator.create(creator_params)
      creator.first_name = 'Ben'

      put "/api/creators/#{creator.id}", creator.to_json
      expect(last_response.status).to eq(200)

      updated_creator = Creator.first(id: creator.id)
      expect(updated_creator.first_name).to eq('Ben')
    end
  end

  describe 'DELETE /api/creators/:id' do
    it 'should insert the creator into the database' do
      creator = Creator.create(creator_params)

      expect { delete "/api/creators/#{creator.id}" }
        .to change { Creator.count }.by(-1)
    end
  end
end
