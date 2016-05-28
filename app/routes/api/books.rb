require_relative '../../models/book'
require 'json'

# Book API Routes
class LongboxApi < Sinatra::Base
  get '/api/books' do
    if params[:publisher]
      Book.all(Book.series.publisher.id => params['publisher']).to_json
    elsif params[:series]
      Book.all(series_id: params[:series]).to_json
    elsif params[:creator]
      Book.all(Book.creators.id => params[:creator]).to_json
    else
      Book.all.to_json
    end
  end

  get '/api/books/:id' do
    book = Book.get(params[:id])
    halt 404 if book.nil?
    book.to_json
  end

  post '/api/books' do
    body = JSON.parse request.body.read
    book = Book.new(
      name: body['name'],
      issue_number: body['issue_number'],
      series_id: body['series_id'],
      created_at: DateTime.now,
      updated_at: DateTime.now
    )

    if book.save
      status 201
      book.to_json
    else
      status 400
      book.errors.full_messages.to_json
    end
  end

  put '/api/books/:id' do
    body = JSON.parse request.body.read
    book = Book.get(params[:id])

    halt 404 if book.nil?

    book.name = body['name']
    book.issue_number = body['issue_number']
    book.series_id = body['series_id']
    book.updated_at = DateTime.now

    if book.save
      book.to_json
    else
      status 400
      book.errors.full_messages.to_json
    end
  end

  delete '/api/books/:id' do
    book = Book.get(params[:id])

    halt 404 if book.nil?

    halt 500 unless book.destroy
  end
end
