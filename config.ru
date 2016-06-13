require 'sinatra/base'
require 'dm-core'
require 'dm-migrations'

Dir.glob('./app/{models,helpers,controllers}/*.rb').each { |file| require file }

ApplicationController.configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/longbox-dev.sqlite3")
end

ApplicationController.configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end

DataMapper.finalize
DataMapper.auto_upgrade!

use BooksController
use CreatorRolesController
use CreatorsController
use PublishersController
use SeriesController
use WebsiteController

run Sinatra::Application
