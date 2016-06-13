require_relative '../spec_helper'

describe Creator do
  let(:creator) { Creator.new(first_name: 'Johnny', last_name: 'Anonymous') }

  it 'is valid' do
    expect(creator).to be_valid
  end

  describe '#first_name' do
    it 'is invalid when empty' do
      creator.first_name = ''
      expect(creator).to_not be_valid
    end
  end

  describe '#last_name' do
    it 'is invalid when empty' do
      creator.last_name = ''
      expect(creator).to_not be_valid
    end
  end
end
