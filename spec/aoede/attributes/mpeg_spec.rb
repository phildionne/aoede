require 'spec_helper'

describe Aoede::Attributes::MPEG do
  let(:filename_mp3) { File.expand_path('Test - Track 320.mp3', 'spec/support/') }
  let(:track) { Aoede::Track.new(filename_mp3) }

  describe :ClassMethods do

    describe :extended do

      it "defines attribute getters on the receiving object" do
        Aoede::Attributes::MPEG::ATTRIBUTES.keys.each do |method|
          expect(track).to respond_to(method)
        end
      end

      it "defines attribute setters on the receiving object" do
        Aoede::Attributes::MPEG::ATTRIBUTES.keys.each do |method|
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
          arranger: nil,
          artist: 'Artist',
          audio_delay: nil,
          audio_length: nil,
          audio_size: nil,
          author: nil,
          bpm: '100',
          comment: 'Comment',
          compilation_flag: nil,
          composer: 'Composer',
          conductor: nil,
          copyright: nil,
          date: nil,
          disc_number: '1/2',
          encoder: nil,
          encoding_settings: nil,
          encoding_time: nil,
          fileowner: nil,
          filetype: nil,
          genre: 'Genre',
          grouping: 'Grouping',
          initial_key: nil,
          involved_people: nil,
          isrc: nil,
          language: nil,
          lyricist: nil,
          mediatype: nil,
          mood: nil,
          musician_credits: nil,
          organization: nil,
          original_album: nil,
          original_artist: nil,
          original_release_time: nil,
          original_year: nil,
          popularimeter: nil,
          produced_notice: nil,
          radio_owner: nil,
          radio_station_name: nil,
          recordingd_ates: nil,
          release_date: '2014',
          release_time: nil,
          set_subtitle: nil,
          sort_album: 'Album sort',
          sort_composer: 'Composer sort',
          sort_performer: 'Artist sort',
          sort_title: 'Title sort',
          tagging_time: nil,
          time: nil,
          title: 'Title',
          track_number: '1/5',
          ufid: nil,
          unsynced_lyrics: nil,
          version: nil,
          wwwartist: nil,
          wwwcommercialinfo: nil,
          wwwcopyright: nil,
          wwwfileinfo: nil,
          wwwpayment: nil,
          wwwpublisher: nil,
          wwwradio: nil,
          wwwsource: nil
        }
      end

      it "returns a hash populated with MPEG attributes values" do
        expect(track.attributes).to eq(attribute_hash)
      end
    end
  end
end
