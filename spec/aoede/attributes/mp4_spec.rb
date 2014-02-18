require 'spec_helper'

describe Aoede::Attributes::MP4 do
  let(:filename_mp4)  { File.expand_path('Test - Track AAC.m4a', 'spec/support/') }
  let(:track) { Aoede::Track.new(filename_mp4) }

  describe :ClassMethods do

    describe :extended do

      it "defines attribute getters on the receiving object" do
        Aoede::Attributes::MP4::ATTRIBUTES.keys.each do |method|
          expect(track).to respond_to(method)
        end
      end

      it "defines attribute setters on the receiving object" do
        Aoede::Attributes::MP4::ATTRIBUTES.keys.each do |method|
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
          artwork: nil,
          bpm: '100',
          category: nil,
          comment: 'Comment',
          compilation: nil,
          composer: 'Composer',
          copyright: nil,
          description: nil,
          disc_number: '1/2',
          encoded_by: nil,
          encoder: 'fdkaac 0.3.0a, libfdk-aac 3.3.3, VBR mode 4',
          episode_global_unique_id: nil,
          gapless_playback: nil,
          genre_predefined: nil,
          genre_user: 'Genre',
          grouping: 'Grouping',
          keyword: nil,
          lyrics: nil,
          media_type: nil,
          purchase_account: nil,
          purchase_date: nil,
          rating_advisory: nil,
          release_date: '2014',
          sort_album: 'Album sort',
          sort_album_artist: 'Album Artist sort',
          sort_artist: 'Artist sort',
          sort_composer: 'Composer sort',
          sort_show: nil,
          sort_title: 'Title sort',
          stik: nil,
          title: 'Title',
          track_number: '1/5',
          tv_episode: nil,
          tv_episode_number: nil,
          tv_network: nil,
          tv_season: nil,
          tv_show_name: nil
        }
      end

      it "returns a hash populated with MP4 attributes values" do
        expect(track.attributes).to eq(attribute_hash)
      end
    end
  end
end
