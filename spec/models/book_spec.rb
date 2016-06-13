require_relative '../spec_helper'

describe Book do
  let(:publisher) { Publisher.create(name: 'Publisher 1') }
  let(:series) { Series.create(name: 'Series 1', publisher_id: publisher.id) }
  let(:book) { Book.new(name: 'Story Arc', issue_number: '1', series_id: series.id) }

  it 'is valid' do
    expect(book).to be_valid
  end

  describe '#name' do
    it 'is valid, even when empty' do
      book.name = ''
      expect(book).to be_valid
    end
  end

  describe '#issue_number' do
    it 'is valid, even when empty' do
      book.issue_number = ''
      expect(book).to be_valid
    end

    it 'is valid with only numbers' do
      book.issue_number = '100'
      expect(book).to be_valid
    end

    it 'is valid with numbers and one \'dot\'' do
      book.issue_number = '1.1'
      expect(book).to be_valid
    end

    it 'is invalid if it begins with \'dot\'' do
      book.issue_number = '.10'.to_s
      expect(book).to_not be_valid
    end

    it 'is invalid if it ends with \'dot\'' do
      book.issue_number = '10.'.to_s
      expect(book).to_not be_valid
    end

    it 'is invalid with alphabetic characters' do
      book.issue_number = 'abc'
      expect(book).to_not be_valid
    end
  end
end
