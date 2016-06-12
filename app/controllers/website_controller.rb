require_relative './application_controller'

# Base Web Routes
class WebsiteController < ApplicationController
  get '/?' do
    send_file File.expand_path('index.html', settings.public_folder)
  end
end
