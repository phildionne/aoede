require 'spec_helper'

describe Aoede::Attributes::Ogg do
  let(:filename_ogg)  { File.expand_path('Test - Track.ogg', 'spec/support/') }
  let(:track) { Aoede::Track.new(filename_ogg) }

  describe :ClassMethods do

    describe :extended do

      it "defines attribute getters on the receiving object" do
        Aoede::Attributes::Ogg::ATTRIBUTES.each do |method|
          expect(track).to respond_to(method)
        end
      end

      it "defines attribute setters on the receiving object" do
        Aoede::Attributes::Ogg::ATTRIBUTES.each do |method|
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
