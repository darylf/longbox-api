# Creator model
class Creator
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String, unique: [:first_name]
  property :created_at, DateTime
  property :updated_at, DateTime

  has n, :creator_roles
  has n, :books, through: :creator_roles
end
