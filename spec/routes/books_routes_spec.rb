require_relative '../spec_helper'
require_relative '../../app/models/book'

describe 'API - Books' do
  include Rack::Test::Methods

  let(:publisher) { Publisher.create(name: 'Perfecto Publishing') }
  let(:series) { Series.create(name: 'Acme Adventures', publisher_id: publisher.id) }
  let(:book_params) { { name: 'Test1', issue_number: 1, series_id: series.id } }

  before(:each) { Book.all.destroy }

  def app
    LongboxApi
  end

  describe 'GET /api/books' do
    it 'should get all books' do
      book = Book.create(book_params)

      get '/api/books'
      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response[0]['name']).to eq(book.name)
    end

    it 'should get books for a specific publisher when params[publisher] is in querystring' do
      publisher1 = Publisher.create(name: 'Publisher1')
      series1 = Series.create(name: 'Another Series', publisher_id: publisher1.id)
      book1 = Book.create(book_params)
      book2 = Book.create(book_params.merge!(series_id: series1.id))

      get "/api/books?publisher=#{publisher.id}"
      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response.find { |x| x['id'] == book2.id }).to be_nil
      expect(response[0]['id']).to eq(book1.id)
    end

    it 'should get books for a specific series when params[series] is in querystring' do
      series1 = Series.create(name: 'Series1', publisher_id: publisher.id)
      book1 = Book.create(book_params)
      book2 = Book.create(book_params.merge!(series_id: series1.id))

      get "/api/books?series=#{series.id}"
      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response.find { |x| x['id'] == book2.id }).to be_nil
      expect(response[0]['id']).to eq(book1.id)
    end

    it 'should get books for a specific creator when params[creator] is in querystring' do
      book1 = Book.create(book_params)
      book2 = Book.create(book_params.merge(name: 'Another Story'))
      creator1 = Creator.create(first_name: 'Stan', last_name: 'Lee')
      creator2 = Creator.create(first_name: 'Bob', last_name: 'Kane')
      CreatorRole.create(book_id: book1.id, creator_id: creator1.id, job: 'writer')
      CreatorRole.create(book_id: book2.id, creator_id: creator2.id, job: 'writer')

      get "/api/books?creator=#{creator1.id}"
      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response.find { |x| x['id'] == book2.id }).to be_nil
      expect(response[0]['id']).to eq(book1.id)
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
      expect { post '/api/books', book_params.to_json }
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
