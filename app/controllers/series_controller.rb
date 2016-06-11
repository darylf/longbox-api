require_relative '../../models/series'
require 'json'

# Series API Routes
class LongboxApi < Sinatra::Base
  get '/api/series' do
    Series.all.to_json
  end

  get '/api/series/:id' do
    series = Series.get(params[:id])
    halt 404 if series.nil?

    options = (!params[:include].nil? && params[:include].include?('books')) ? { methods: [:books] } : {}

    series.to_json(options)
  end

  post '/api/series' do
    body = JSON.parse request.body.read
    series = Series.new(
      name: body['name'],
      publisher_id: body['publisher_id'],
      created_at: DateTime.now,
      updated_at: DateTime.now
    )

    if series.save
      status 201
      series.to_json
    else
      status 400
      series.errors.full_messages.to_json
    end
  end

  put '/api/series/:id' do
    body = JSON.parse request.body.read
    series = Series.get(params[:id])
    halt 404 if series.nil?

    series.name = body['name']
    series.updated_at = DateTime.now

    if series.save
      series.to_json
    else
      status 400
      series.errors.full_messages.to_json
    end
  end

  delete '/api/series/:id' do
    series = Series.get(params[:id])

    halt 404 if series.nil?
    halt 500 unless series.destroy
  end
end
