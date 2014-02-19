require 'spec_helper'

describe Aoede::Attributes::Flac do
  let(:filename_flac)  { File.expand_path('Test - Track.flac', 'spec/support/') }
  let(:track) { Aoede::Track.new(filename_flac) }

  describe :ClassMethods do

    describe :extended do

      it "defines attribute getters on the receiving object" do
        Aoede::Attributes::Flac::ATTRIBUTES.each do |method|
          expect(track).to respond_to(method)
        end
      end

      it "defines attribute setters on the receiving object" do
        Aoede::Attributes::Flac::ATTRIBUTES.each do |method|
          expect(track).to respond_to("#{method}=")
        end
      end
    end
  end

  describe :InstanceMethods do

    describe :attributes do
      let(:attribute_hash) do
        {
          album: 'Album',
          artist: 'Artist',
          comment: 'Comment',
          genre: 'Genre',
          title: 'Title',
          track_number: 1,
          release_date: 2014
        }
      end

      it "returns a hash populated with MP4 attributes values" do
        expect(track.attributes).to eq(attribute_hash)
      end
    end
  end
end
