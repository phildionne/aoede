require 'spec_helper'

describe Aoede::Library do

  describe :InstanceMethod do
    let(:library) { Aoede::Library.new(File.expand_path('spec/support/')) }

    describe :filenames do
      it { expect(library.filenames).to be_a(Array) }
      it { expect(library.filenames.first).to be_a(String) }

      context "without a path" do
        it { expect { Aoede::Library.new.filenames }.to raise_error }
      end
    end

    describe :tracks do
      it { expect(library.tracks).to be_a(Array) }
      it { expect(library.tracks.first).to be_a(Aoede::Track) }
    end

    describe :select_by do
      it { expect(library.select_by).to be_a(Array) }
      it { expect(library.select_by(title: "Title").first).to be_a(Aoede::Track) }
      it { expect(library.select_by(title: "Title").first.title).to eq("Title") }
      it { expect(library.select_by(title: "Title", artist: "Artist").first.artist).to eq("Artist") }
    end
  end
end
