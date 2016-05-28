require_relative '../../models/publisher'
require 'json'

# Publisher API Routes
class LongboxApi < Sinatra::Base
  get '/api/publishers' do
    Publisher.all.to_json
  end

  get '/api/publishers/:id' do
    publisher = Publisher.get(params[:id])
    halt 404 if publisher.nil?

    publisher.to_json
  end

  post '/api/publishers' do
    body = JSON.parse request.body.read
    publisher = Publisher.new(
      name: body['name'],
      created_at: DateTime.now,
      updated_at: DateTime.now
    )

    if publisher.save
      status 201
      publisher.to_json
    else
      status 400
      publisher.errors.full_messages.to_json
    end
  end

  put '/api/publishers/:id' do
    body = JSON.parse request.body.read
    publisher = Publisher.get(params[:id])
    halt 404 if publisher.nil?

    publisher.name = body['name']
    publisher.updated_at = DateTime.now

    if publisher.save
      publisher.to_json
    else
      status 400
      publisher.errors.full_messages.to_json
    end
  end

  delete '/api/publishers/:id' do
    publisher = Publisher.get(params[:id])

    halt 404 if publisher.nil?
    halt 500 unless publisher.destroy
  end
end
