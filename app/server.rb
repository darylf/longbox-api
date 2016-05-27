# This site allows users to track a comic book
# collection, and present statistics about
# popular publishers and creators. Users are
# able to add/update/delete entities.
#
# Author::    Daryl Fritz  (http://darylfritz.com)
# Copyright:: Copyright (c) 2016 Daryl Fritz
# License::   GNU General Public License (GPL) version 3

ENV['RACK_ENV'] ||= 'development'

require 'sinatra'
require 'data_mapper'

# This class acts as the "main" script. It
# initializes the database, models, and
# routes.
class LongboxApi < Sinatra::Base
  configure :development do
    db_dev = "sqlite3://#{Dir.pwd}/db/longbox-api.devl.sqlite3"
    DataMapper.setup :default, db_dev
  end

  configure :test do
    DataMapper.setup(:default, 'sqlite::memory:')
  end

  configure :production do
    DataMapper.setup(:default, ENV['DATABASE_URL'])
  end

  require_relative 'models/init'
  DataMapper.finalize.auto_upgrade!
  require_relative 'routes/init'

  run! if app_file == $PROGRAM_NAME
end
