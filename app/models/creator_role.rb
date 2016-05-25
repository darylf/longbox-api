# Creator/Role model
class CreatorRole
  include DataMapper::Resource

  property :id, Serial
  property :job, String, unique: [:book_id, :creator_id]
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :book
  belongs_to :creator
end

# Creator model (add fields)
class Creator
  has n, :creator_roles
  has n, :books, through: :creator_roles
end

# Book model (add fields)
class Book
  has n, :creator_roles
  has n, :creators, through: :creator_roles
end
