Dir.glob('./app/models/*.rb').each { |file| require file }

# Seed the database with data
class DBSeeder
  def self.seed_db
    DataMapper.finalize.auto_migrate!

    seed_publishers
    seed_creators
    seed_series
    seed_books

    'DB Seed Complete!'
  end

  def self.seed_publishers
    Publisher.first_or_create(name: 'Marvel Comics')
    Publisher.first_or_create(name: 'DC Comics')
    Publisher.first_or_create(name: 'IDW Publishing')
    Publisher.first_or_create(name: 'Image Comics')
  end

  def self.seed_creators
    Creator.first_or_create(first_name: 'Stan', last_name: 'Lee')
    Creator.first_or_create(first_name: 'Ed', last_name: 'Brubaker')
    Creator.first_or_create(first_name: 'Greg', last_name: 'Capullo')
    Creator.first_or_create(first_name: 'Matt', last_name: 'Fraction')
    Creator.first_or_create(first_name: 'Scott', last_name: 'Snyder')
    Creator.first_or_create(first_name: 'Fiona', last_name: 'Staples')
    Creator.first_or_create(first_name: 'Brian K.', last_name: 'Vaughan')
    Creator.first_or_create(first_name: 'Chip', last_name: 'Zdarsky')
  end

  def self.seed_series
    Series.create(name: 'Batman', publisher_id: Publisher.first(name: 'DC Comics').id)
    Series.create(name: 'Immortal Iron Fist', publisher_id: Publisher.first(name: 'Marvel Comics').id)
    Series.create(name: 'Saga', publisher_id: Publisher.first(name: 'Image Comics').id)
  end

  def self.seed_books
    scott = Creator.first(first_name: 'Scott', last_name: 'Snyder')
    batman = Book.create(issue_number: 1, name: 'Court of Owls', series_id: Series.first(name: 'Batman').id)
    CreatorRole.create(book_id: batman.id, creator_id: scott.id, job: 'writer')

    matt = Creator.first(first_name: 'Matt', last_name: 'Fraction')
    iron_fist = Book.create(issue_number: 1, name: 'The Last Iron Fist Story', series_id: Series.first(name: 'Immortal Iron Fist').id)
    CreatorRole.create(book_id: iron_fist.id, creator_id: matt.id, job: 'writer')

    brian = Creator.first(first_name: 'Brian K.', last_name: 'Vaughan')
    saga = Book.create(issue_number: 1, name: 'Chapter One', series_id: Series.first(name: 'Saga').id)
    CreatorRole.create(book_id: saga.id, creator_id: brian.id, job: 'writer')
  end
end
