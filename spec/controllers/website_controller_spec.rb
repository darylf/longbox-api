require_relative '../spec_helper'
require_relative '../../app/controllers/website_controller'

describe 'Longbox' do
  include Rack::Test::Methods

  def app
    WebsiteController
  end

  it 'displays home page' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('<h1>Longbox')
  end
end
