require 'dm-core'
require 'dm-validations'

require_relative './publisher'

# Series model
class Series
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :publisher
  has n, :books

  validates_presence_of :name
end
