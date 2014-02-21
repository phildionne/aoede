require 'spec_helper'

describe Aoede::Attributes::MPEG do
  let(:filename_mp3) { File.expand_path('Test - Track 320.mp3', 'spec/support/') }
  let(:track) { Aoede::Track.new(filename_mp3) }

  describe :ClassMethods do

    describe :extended do

      it "defines attribute getters on the receiving object" do
        Aoede::Attributes::MPEG::ATTRIBUTES.each do |method|
          expect(track).to respond_to(method)
        end
      end

      it "defines attribute setters on the receiving object" do
        Aoede::Attributes::MPEG::ATTRIBUTES.each do |method|
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
          album_artist: 'Album Artist',
          artist: 'Artist',
          bpm: '100',
          comment: 'Comment',
          composer: 'Composer',
          copyright: 'Copyright',
          disc_number: '1/2',
          genre: 'Genre',
          grouping: 'Grouping',
          language: 'Language',
          lyrics: 'Lyrics',
          organization: 'Editor',
          release_date: '2014',
          sort_album: 'Album sort',
          sort_album_artist: 'Album Artist sort',
          sort_artist: 'Artist sort',
          sort_composer: 'Composer sort',
          sort_title: 'Title sort',
          title: 'Title',
          track_number: '1'
        }
      end

      it "returns a hash populated with MPEG attributes values" do
        expect(track.attributes).to eq(attribute_hash)
      end
    end

    describe :audio_properties do
      let(:track) { Aoede::Track.new(filename_mp3, audio_properties: true) }
      let(:audio_properties_hash) do
        {
          bitrate: 320,
          channels: 2,
          length: 279,
          sample_rate: 44100,
          layer: 3,
          original?: true,
          version: 0
        }
      end

      it "returns a hash populated with MPEG audio properties values" do
        expect(track.audio_properties).to eq(audio_properties_hash)
      end
    end

    describe :images do
      it { expect(track.images).to be_a(Array) }
      it { expect(track.images.first).to be_a(Aoede::Image) }
    end

    describe :add_image do
      let(:file) { File.new(File.expand_path('cover.jpeg', 'spec/support/')) }
      let(:image) { Aoede::Image.new(data: file.read, format: :jpeg) }

      it "adds a new image" do
        expect {
          track.add_image(image)
        }.to change(track.images, :count).by(1)
      end

      it "adds the right image" do
        track.add_image(image)
        expect(track.images.last.data.b).to eq(image.data.b)
      end
    end

    describe :delete_images do

      it "deletes all images" do
        expect {
          track.delete_images
        }.to change(track.images, :count).by(-1)
      end
    end
  end
end
