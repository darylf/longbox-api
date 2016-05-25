# Book model
class Book
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :issue_number, Integer
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :publisher
end
