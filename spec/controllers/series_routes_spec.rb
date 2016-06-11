require_relative '../spec_helper'
require_relative '../../app/controllers/series_controller'

describe 'API - Series' do
  include Rack::Test::Methods

  def app
    SeriesController
  end

  let(:publisher) { Publisher.create(name: 'Perfecto Publishing') }
  let(:series_params) { { name: 'Acme Adventures', publisher_id: publisher.id } }

  before(:each) { Series.all.destroy }

  describe 'GET /api/series' do
    it 'should get all series' do
      Series.create(series_params)

      get '/api/series'
      expect(last_response).to be_ok
    end

    it 'should filter all series by publisher when params[publisher] is provided' do
      publisher2 = Publisher.create(name: 'Another Publisher')
      Series.create(series_params)
      Series.create(name: 'Another Series', publisher_id: publisher2.id)

      get "/api/series?publisher=#{publisher.id}"
      expect(last_response).to be_ok
    end
  end

  describe 'GET /api/series/:id' do
    it 'should display a specific series' do
      series = Series.create(series_params)

      get "/api/series/#{series.id}"
      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response['name']).to eq('Acme Adventures')
    end
  end

  describe 'POST /api/series' do
    it 'should insert the series into the database' do
      expect { post '/api/series', series_params.to_json }
        .to change { Series.count }.by(1)

      expect(last_response.status).to eq(201)
    end
  end

  describe 'PUT /api/series/:id' do
    it 'should insert the series into the database' do
      series = Series.create(series_params)

      series.name = 'Test2'

      put "/api/series/#{series.id}", series.to_json
      expect(last_response.status).to eq(200)

      updated_series = Series.first(id: series.id)
      expect(updated_series.name).to eq('Test2')
    end
  end

  describe 'DELETE /api/series/:id' do
    it 'should insert the series into the database' do
      series = Series.create(series_params)

      expect { delete "/api/series/#{series.id}" }
        .to change { Series.count }.by(-1)
    end
  end
end
