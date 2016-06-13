require 'dm-core'
require 'dm-migrations'
require 'dm-validations'

require_relative './series'
require_relative './creator_role'

# Book model
class Book
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :issue_number, String
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :series

  has n, :creator_roles
  has n, :creators, through: :creator_roles

  validates_format_of :issue_number, with: /^\d+$|^\d+\.?\d+$/
  # example: 1 or 1.0
end
