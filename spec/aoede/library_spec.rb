require 'spec_helper'

describe Aoede::Library do

  describe :InstanceMethod do
    let(:library) { Aoede::Library.new(File.expand_path('spec/support/')) }

    describe :files do
      it { expect(library.files).to be_a(Enumerator) }
      it { expect(library.files.first).to be_a(String) }

      context "without a path" do

        it { expect { Aoede::Library.new.files }.to raise_error }
      end
    end

    describe :tracks do
      it { expect(library.tracks).to be_a(Enumerator) }
      it { expect(library.tracks.first).to be_a(Aoede::Track) }
    end
  end
end
