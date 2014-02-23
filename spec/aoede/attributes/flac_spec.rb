require 'spec_helper'

describe Aoede::Attributes::Flac do
  let(:filename_flac) { File.expand_path('Artist - Title.flac', 'spec/support/') }
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

    Aoede::Attributes::Flac::ATTRIBUTES
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

      it "returns a hash populated with Flac attributes values" do
        expect(track.attributes).to eq(attribute_hash)
      end
    end

    describe :audio_properties do
      let(:track) { Aoede::Track.new(filename_flac, audio_properties: true) }
      let(:audio_properties_hash) do
        {
          bitrate: 1641,
          channels: 2,
          length: 10,
          sample_rate: 44100,
          sample_width: 24,
          signature: "\x1A.\xA4\xBA\x05O~\xB7\xA9\xC8z\xB5\xE7O\xFD\x9C".b # ASCI-8BIT
        }
      end

      it "returns a hash populated with Flac audio properties values" do
        expect(track.audio_properties).to eq(audio_properties_hash)
      end
    end

    describe :images do
      it { expect(track.images).to be_a(Array) }
      it { expect(track.images.first).to be_a(Aoede::Image) }
    end

    describe :add_image do
      let(:file) { File.new(File.expand_path('cover.jpeg', 'spec/support/')) }
      let(:image) { Aoede::Image.new(data: file.read, format: :jpeg, width: 200, height: 200) }

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
        track.delete_images
        expect(track.images).to be_empty
      end
    end
  end
end
