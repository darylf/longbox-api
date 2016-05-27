source 'https://rubygems.org'
ruby '2.2.4'

gem 'sinatra'
gem 'data_mapper'
gem 'json'

group :development, :test do
  gem 'sqlite3'
  gem 'dm-sqlite-adapter'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
end

group :production do
  gem 'dm-postgres-adapter'
end
