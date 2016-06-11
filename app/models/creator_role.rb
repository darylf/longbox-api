require 'dm-core'
require 'dm-migrations'

require_relative './book'
require_relative './creator'

# Creator/Role model
class CreatorRole
  include DataMapper::Resource

  property :id, Serial
  property :job, String
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :book
  belongs_to :creator
end
