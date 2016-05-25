ENV['RACK_ENV'] = 'test'

require_relative '../app/server'
require 'rspec'
require 'rack/test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
