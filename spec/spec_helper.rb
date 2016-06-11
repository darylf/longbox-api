ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'sinatra'
require 'rack/test'
require 'data_mapper'

# set test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false

# Load all models
# Dir.glob('../app/models/*.rb').each { |file| require file }
Dir.glob('./app/models/*.rb').each { |file| require file }

# establish in-memory database for testing
DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.finalize

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:each) { DataMapper.auto_migrate! }
end
