require 'spec_helper'

describe Aoede::Library do

  describe :InstanceMethod do
    let(:library) { Aoede::Library.new(File.expand_path('spec/support/')) }

    describe :files do
      it { expect(library.files).to be_a(Array) }
      it { expect(library.files.first).to be_a(String) }

      context "without a path" do

        it { expect { Aoede::Library.new.files }.to raise_error }
      end
    end

    describe :tracks do
      it { expect(library.tracks).to be_a(Array) }
      it { expect(library.tracks.first).to be_a(Aoede::Track) }
    end

    describe :find_by do
      it { expect(library.find_by(title: "Title").first).to be_a(Aoede::Track) }
      it { expect(library.find_by(title: "Title").first.title).to eq("Title") }
      it { expect(library.select_by).to be_a(Array) }
    end
  end
end
