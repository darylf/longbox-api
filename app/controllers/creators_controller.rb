require_relative './application_controller'

# Creator API Routes
class CreatorsController < ApplicationController
  get '/api/creators/?' do
    Creator.all.to_json
  end

  get '/api/creators/:id' do
    creator = Creator.get(params[:id])
    halt 404 if creator.nil?

    creator.to_json
  end

  post '/api/creators/?' do
    body = JSON.parse request.body.read
    creator = Creator.new(
      first_name: body['first_name'],
      last_name: body['last_name'],
      created_at: DateTime.now,
      updated_at: DateTime.now
    )

    if creator.save
      status 201
      creator.to_json
    else
      status 400
      creator.errors.full_messages.to_json
    end
  end

  put '/api/creators/:id' do
    body = JSON.parse request.body.read
    creator = Creator.get(params[:id])
    halt 404 if creator.nil?

    creator.first_name = body['first_name']
    creator.last_name = body['last_name']
    creator.updated_at = DateTime.now

    if creator.save
      creator.to_json
    else
      status 400
      creator.errors.full_messages.to_json
    end
  end

  delete '/api/creators/:id' do
    creator = Creator.get(params[:id])

    halt 404 if creator.nil?
    halt 500 unless creator.destroy
  end
end
