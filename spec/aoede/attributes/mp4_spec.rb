require 'spec_helper'

describe Aoede::Attributes::MP4 do
  let(:filename_mp4) { File.expand_path('Artist - Title AAC.m4a', 'spec/support/') }
  let(:track) { Aoede::Track.new(filename_mp4) }

  it "all Attributes have a Mapping" do
    expect(Aoede::Attributes::MP4::ATTRIBUTES.all? do |key|
      Aoede::Attributes::MP4::MAPPING.key?(key)
    end).to be_true
  end

  describe :ClassMethods do

    describe :extended do

      it "defines attribute getters on the receiving object" do
        Aoede::Attributes::MP4::ATTRIBUTES.each do |method|
          expect(track).to respond_to(method)
        end
      end

      it "defines attribute setters on the receiving object" do
        Aoede::Attributes::MP4::ATTRIBUTES.each do |method|
          expect(track).to respond_to("#{method}=")
        end
      end
    end
  end

  describe :InstanceMethods do

    Aoede::Attributes::MP4::ATTRIBUTES.each do |method|
      it "sets attribute '#{method}'" do
        track.send("#{method}=", "value")
        expect(track.send(method)).to eq("value")
      end
    end

    describe :attributes do
      let(:attribute_hash) do
        {
          album: 'Album',
          album_artist: 'Album Artist',
          artist: 'Artist',
          bpm: '100',
          comment: 'Comment',
          composer: 'Composer',
          disc_number: '1/2',
          encoder: 'Encoder',
          genre: 'Genre',
          grouping: 'Grouping',
          lyrics: 'Lyrics',
          release_date: '2014',
          sort_album: 'Album sort',
          sort_album_artist: 'Album Artist sort',
          sort_artist: 'Artist sort',
          sort_composer: 'Composer sort',
          sort_title: 'Title sort',
          title: 'Title',
          track_number: '1/5'
        }
      end

      it "returns a hash populated with MP4 attributes values" do
        expect(track.attributes).to eq(attribute_hash)
      end
    end

    describe :audio_properties do
      let(:track) { Aoede::Track.new(filename_mp4, audio_properties: true) }
      let(:audio_properties_hash) do
        {
          bitrate: 125,
          channels: 2,
          length: 10,
          sample_rate: 44100,
          bits_per_sample: 16
        }
      end

      it "returns a hash populated with MP4 audio properties values" do
        expect(track.audio_properties).to eq(audio_properties_hash)
      end
    end

    describe :image do
      let(:file) { File.new(File.expand_path('cover.jpeg', 'spec/support/')) }
      let(:image) { Aoede::Image.new(data: file.read, format: :jpeg) }

      it_behaves_like "image getter"
    end

    describe :image= do
      let(:file) { File.new(File.expand_path('cover.jpeg', 'spec/support/')) }
      let(:image) { Aoede::Image.new(data: file.read, format: :jpeg) }
      let(:other_image) { Aoede::Image.new(data: file.read, format: :jpeg) }

      it_behaves_like "image setter"
    end

    describe :delete_image do

      it "deletes the image" do
        track.delete_image
        expect(track.image).to be_nil
      end
    end
  end
end
