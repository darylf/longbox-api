require_relative '../spec_helper'
require_relative '../../app/models/publisher'

describe 'API - Publishers' do
  include Rack::Test::Methods

  def app
    LongboxApi
  end

  before(:each) { Publisher.all.destroy }

  describe 'GET /api/publishers' do
    it 'should get all publishers' do
      Publisher.create(name: 'Test1')

      get '/api/publishers'
      expect(last_response).to be_ok
    end
  end

  describe 'GET /api/publishers/:id' do
    it 'should display a specific publisher' do
      publisher = Publisher.create(name: 'Test1')

      get "/api/publishers/#{publisher.id}"
      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response['name']).to eq('Test1')
    end

    it 'should load books if "include" param passed in query string' do
      publisher = Publisher.create(name: 'Test1')
      Book.create(name: 'Batman', issue_number: 1, publisher_id: publisher.id)

      get "/api/publishers/#{publisher.id}?include=books"
      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response['books'][0]['name']).to eq('Batman')
    end

    it 'should NOT load books if "include" param is not in query string' do
      publisher = Publisher.create(name: 'Test1')
      Book.create(name: 'Batman', issue_number: 1, publisher_id: publisher.id)

      get "/api/publishers/#{publisher.id}"
      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response['books']).to be_nil
    end
  end

  describe 'POST /api/publishers' do
    it 'should insert the publisher into the database' do
      params = {
        name: 'test1'
      }

      expect { post '/api/publishers', params.to_json }
        .to change { Publisher.count }.by(1)

      expect(last_response.status).to eq(201)
    end
  end

  describe 'PUT /api/publishers/:id' do
    it 'should insert the publisher into the database' do
      publisher = Publisher.create(name: 'Test1')

      publisher.name = 'Test2'

      put "/api/publishers/#{publisher.id}", publisher.to_json
      expect(last_response.status).to eq(200)

      updated_publisher = Publisher.first(id: publisher.id)
      expect(updated_publisher.name).to eq('Test2')
    end
  end

  describe 'DELETE /api/publishers/:id' do
    it 'should insert the publisher into the database' do
      publisher = Publisher.create(name: 'Test1')

      expect { delete "/api/publishers/#{publisher.id}" }
        .to change { Publisher.count }.by(-1)
    end
  end
end
