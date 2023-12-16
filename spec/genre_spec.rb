# spec/genre_spec.rb

require_relative '../genre'

RSpec.describe Genre do
  let(:genre_name) { 'Science Fiction' }
  let(:genre) { described_class.new(genre_name) }

  describe '#initialize' do
    it 'creates a new genre with a name' do
      expect(genre).to be_a(Genre)
      expect(genre.name).to eq(genre_name)
    end

    it 'generates a random id' do
      expect { genre.send(:id) }.to_not raise_error
    end

    it 'initializes with an empty items array' do
      expect(genre.items).to be_empty
    end
  end

  describe '#add_item' do
    let(:book) { instance_double('Book') }

    it 'sets the genre of the added item' do
      expect(book).to receive(:genre=).with(genre).once
      genre.add_item(book)
    end
  end
end
