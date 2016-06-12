require_relative './application_controller'

# Creator/Roles API Routes
class CreatorRolesController < ApplicationController
  get '/api/creator_roles/?' do
    CreatorRole.all.to_json
  end

  get '/api/creator_roles/:id' do
    creator_role = CreatorRole.get(params[:id])

    halt 404 if creator_role.nil?

    creator_role.to_json
  end

  post '/api/creator_roles/?' do
    body = JSON.parse request.body.read
    creator_role = CreatorRole.new(
      book_id: body['book_id'],
      creator_id: body['creator_id'],
      job: body['job'],
      created_at: DateTime.now,
      updated_at: DateTime.now
    )

    if creator_role.save
      status 201
      creator_role.to_json
    else
      status 400
      creator_role.errors.full_messages.to_json
    end
  end

  put '/api/creator_roles/:id' do
    body = JSON.parse request.body.read
    creator_role = CreatorRole.get(params[:id])
    halt 404 if creator_role.nil?

    creator_role.book_id = body['book_id']
    creator_role.creator_id = body['creator_id']
    creator_role.job = body['job']
    creator_role.updated_at = DateTime.now

    if creator_role.save
      creator_role.to_json
    else
      status 400
      creator_role.errors.full_messages.to_json
    end
  end

  delete '/api/creator_roles/:id' do
    creator_role = CreatorRole.get(params[:id])

    halt 404 if creator_role.nil?
    halt 500 unless creator_role.destroy
  end
end
