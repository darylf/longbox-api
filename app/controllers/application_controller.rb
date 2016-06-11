$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'sinatra/base'
require 'json'

# Aplication Controller
class ApplicationController < Sinatra::Base
  # helpers ApplicationHelpers

  set :views, File.expand_path('../../views', __FILE__)
  enable :sessions, :method_override
end
