require 'spec_helper'

describe 'Longbox' do
  include Rack::Test::Methods

  def app
    LongboxApi
  end

  it 'displays home page' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('<h1>Longbox')
  end
end
