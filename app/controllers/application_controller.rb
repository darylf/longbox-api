$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'sinatra/base'
require 'json'

# Aplication Controller
class ApplicationController < Sinatra::Base
  # helpers ApplicationHelpers

  set :root, File.expand_path('../../', __FILE__)
  enable :sessions, :method_override
end
