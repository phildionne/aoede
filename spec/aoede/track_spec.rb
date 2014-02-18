require 'spec_helper'

describe Aoede::Track do
  let(:filename_mp3)  { File.expand_path('Test - Track 320.mp3', 'spec/support/') }
  let(:filename_mp4)  { File.expand_path('Test - Track AAC.m4a', 'spec/support/') }
  let(:filename_flac) { File.expand_path('Test - Track.flac', 'spec/support/') }
  let(:filename_ogg)  { File.expand_path('Test - Track.ogg', 'spec/support/') }
  let(:filename_wav)  { File.expand_path('Test - Track.wav', 'spec/support/') }

  describe :InstanceMethods do

    describe :new do
      let(:track) { Aoede::Track.new(filename_mp3) }

      it "initializes a new track with the given filename" do
        expect(track.filename).to eq(filename_mp3)
      end
    end

    describe :to_hash do
      let(:track) { Aoede::Track.new(filename_mp3) }

      it "returns a hash of attributes with their value" do
        expect(track.to_hash).to be_a(Hash)

        track.attributes.each do |key, value|
          expect(track.to_hash[key]).to eq(track.send(key))
        end
      end
    end

    describe :filename= do
      let(:track) { Aoede::Track.new(filename_mp3) }

      context "with an existing file" do

        it "sets the filename" do
          expect(track.filename).to eq(filename_mp3)
        end
      end

      context "with an inexisting file" do

        it "doesn't sets the inexisting filename" do
          begin
            track.filename = "inexisting/file"
          rescue StandardError
          end

          expect(track.filename).not_to eq("inexisting/file")
        end

        it "raises an error" do
          expect {
            track.filename = "inexisting/file"
          }.to raise_error
        end
      end
    end

    describe :audio do

      context "with a .mp3 file" do
        let(:track) { Aoede::Track.new(filename_mp3) }

        it "returns a TagLib::MPEG::File" do
          expect(track.audio).to be_a(TagLib::MPEG::File)
        end
      end

      context "with a .mp4 file" do
        let(:track) { Aoede::Track.new(filename_mp4) }

        it "returns a TagLib::MP4::File" do
          expect(track.audio).to be_a(TagLib::MP4::File)
        end
      end

      context "with a .flac file" do
        let(:track) { Aoede::Track.new(filename_flac) }

        it "returns a TagLib::FLAC::File" do
          expect(track.audio).to be_a(TagLib::FLAC::File)
        end
      end

      context "with a .ogg file" do
        let(:track) { Aoede::Track.new(filename_ogg) }

        it "returns a TagLib::OGG::Vorbis::File" do
          expect(track.audio).to be_a(TagLib::Ogg::Vorbis::File)
        end
      end

      context "with a .wav file" do
        let(:track) { Aoede::Track.new(filename_wav) }

        it "returns a TagLib::FileRef" do
          expect(track.audio).to be_a(TagLib::FileRef)
        end
      end
    end

    describe :update do
      pending
    end

    describe :save do
      pending
    end

    describe :close do
      pending
    end
  end
end
