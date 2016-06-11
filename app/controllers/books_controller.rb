require_relative '../../models/book'
require 'json'

# Book API Routes
class LongboxApi < Sinatra::Base
  get '/api/books' do
    options = { conditions: {} }
    options[:conditions][Book.series.publisher.id] = params[:publisher] if params[:publisher]
    options[:conditions][:series_id] = params[:series] if params[:series]
    options[:conditions][Book.creators.id] = params[:creator] if params[:creator]

    Book.all(options).to_json(relationships: { series: { methods: [:publisher] } })
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
