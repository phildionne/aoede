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
          # arranger: ,
          artist: 'Artist',
          # audio_delay: ,
          # audio_length: ,
          # audio_size: ,
          # author: ,
          bpm: '100',
          comment: 'Comment',
          # compilation_flag: ,
          composer: 'Composer',
          # conductor: ,
          # copyright: ,
          # date: ,
          disc_number: '1/2',
          encoder: 'fdkaac 0.3.0a, libfdk-aac 3.3.3, VBR mode 4',
          # encoding_settings: ,
          # encoding_time: ,
          # filename: ,
          # fileowner: ,
          # filetype: ,
          genre: 'Genre',
          grouping: 'Grouping',
          # initial_key: ,
          # involved_people: ,
          # isrc: ,
          # language: ,
          # lyricist: ,
          # mediatype: ,
          # mood: ,
          # musician_credits: ,
          # organization: ,
          # original_album: ,
          # original_artist: ,
          # original_release_time: ,
          # original_year: ,
          # popularimeter: ,
          # produced_notice: ,
          # radio_owner: ,
          # radio_station_name: ,
          # recordingd_ates: ,
          # release_time: ,
          # set_subtitle: ,
          sort_album: 'Album sort',
          sort_composer: 'Composer sort',
          sort_performer: 'Artist sort',
          sort_title: 'Title sort',
          # tagging_time: ,
          # time: ,
          title: 'Title',
          track: '1/5',
          # ufid: ,
          # unsynced_lyrics: ,
          # version: ,
          # wwwartist: ,
          # wwwcommercialinfo: ,
          # wwwcopyright: ,
          # wwwfileinfo: ,
          # wwwpayment: ,
          # wwwpublisher: ,
          # wwwradio: ,
          # wwwsource: ,
          year: '2014'
        }
      end

      it "returns a hash populated with MPEG attributes values" do
        expect(track.attributes).to eq(attribute_hash)
      end
    end
  end
end
