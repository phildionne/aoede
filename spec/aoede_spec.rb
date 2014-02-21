require 'spec_helper'

describe Aoede do

  describe :library do
    let(:path) { File.expand_path('spec/support/') }

    it { expect(Aoede.library(path)).to be_a(Aoede::Library) }
    it { expect(Aoede.library(path).path).to eq(path) }
  end

  describe :track do
    let(:filename) { File.expand_path('Artist - Title.mp3', 'spec/support/') }

    it { expect(Aoede.track(filename)).to be_a(Aoede::Track) }
    it { expect(Aoede.track(filename).filename).to eq(filename) }
  end
end
