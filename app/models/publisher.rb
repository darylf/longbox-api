require 'dm-core'
require 'dm-migrations'

require_relative './series'
require_relative './book'

# Publisher model
class Publisher
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :created_at, DateTime
  property :updated_at, DateTime

  has n, :series
  has n, :books, through: :series
end
