require 'spec_helper'

describe Aoede::Attributes::Ogg do
  let(:filename_ogg)  { File.expand_path('Artist - Title.ogg', 'spec/support/') }
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

    Aoede::Attributes::Ogg::ATTRIBUTES
      .reject { |attr| attr == :release_date || attr == :track_number }
      .each do |method|
        it "sets attribute '#{method}'" do
          track.send("#{method}=", "value")
          expect(track.send(method)).to eq("value")
        end
      end

    describe :release_date= do
      before { track.release_date = 2014 }
      it { expect(track.release_date).to eq(2014) }
    end

    describe :track_number= do
      before { track.track_number = 1 }
      it { expect(track.track_number).to eq(1) }
    end

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

    describe :audio_properties do
      let(:track) { Aoede::Track.new(filename_ogg, audio_properties: true) }
      let(:audio_properties_hash) do
        {
          bitrate: 0,
          channels: 2,
          length: 10,
          sample_rate: 44100,
          bitrate_maximum: 0,
          bitrate_minimum: 0,
          bitrate_nominal: 0,
          vorbis_version: 0
        }
      end

      it "returns a hash populated with Ogg audio properties values" do
        expect(track.audio_properties).to eq(audio_properties_hash)
      end
    end
  end
end
