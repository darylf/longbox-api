require_relative '../spec_helper'
require_relative '../../app/models/book'

describe 'API - Books' do
  include Rack::Test::Methods

  let(:publisher) { Publisher.create(name: 'Acme Publishing') }
  let(:book_params) { { name: 'Test1', issue_number: 1, publisher_id: publisher.id } }

  before(:each) { Book.all.destroy }

  def app
    LongboxApi
  end

  describe 'GET /api/books' do
    it 'should get all books' do
      Book.create(book_params)

      get '/api/books'
      expect(last_response).to be_ok
    end
  end

  describe 'GET /api/books/:id' do
    it 'should display a specific book' do
      book = Book.create(book_params)

      get "/api/books/#{book.id}"
      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response['name']).to eq('Test1')
    end
  end

  describe 'POST /api/books' do
    it 'should insert the book into the database' do
      params = {
        name: 'test1',
        issue_number: 1,
        publisher_id: publisher.id
      }

      expect { post '/api/books', params.to_json }
        .to change { Book.count }.by(1)

      expect(last_response.status).to eq(201)
    end
  end

  describe 'PUT /api/books/:id' do
    it 'should insert the book into the database' do
      book = Book.create(book_params)
      book.name = 'Test2'

      put "/api/books/#{book.id}", book.to_json
      expect(last_response.status).to eq(200)

      updated_book = Book.first(id: book.id)
      expect(updated_book.name).to eq('Test2')
    end
  end

  describe 'DELETE /api/books/:id' do
    it 'should insert the book into the database' do
      book = Book.create(book_params)

      expect { delete "/api/books/#{book.id}" }
        .to change { Book.count }.by(-1)
    end
  end
end
