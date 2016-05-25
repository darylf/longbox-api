require_relative 'api/books'
require_relative 'api/creator_roles'
require_relative 'api/creators'
require_relative 'api/publishers'

# Base Web Routes
class LongboxApi < Sinatra::Base
  get '/' do
    send_file File.expand_path('index.html', settings.public_folder)
  end
end
