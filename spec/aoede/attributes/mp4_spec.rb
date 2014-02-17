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
          artwork: '', # FIXME
          bpm: '100',
          # category: track.category,
          comment: 'Comment',
          # compilation: track.compilation,
          composer: 'Composer',
          # copyright: track.copyright,
          # description: track.description,
          disk_number: '1/2',
          encoder: 'fdkaac 0.3.0a, libfdk-aac 3.3.3, VBR mode 4',
          # episode_global_unique_id: track.episode_global_unique_id,
          # gapless_playback: track.gapless_playback,
          genre: 'Genre',
          grouping: 'Grouping',
          # keyword: track.keyword,
          # lyrics: track.lyrics,
          # podcast: track.podcast,
          # podcast_url: track.podcast_url,
          # purchase_date: track.purchase_date,
          # rating_advisory: track.rating_advisory,
          sort_album: 'Album sort',
          sort_album_artist: 'Album Artist sort',
          sort_composer: 'Composer sort',
          sort_artist: 'Artist sort',
          sort_title: 'Title sort',
          # stik: track.stik,
          title: 'Title',
          track_number: '1/5',
          # tv_episode: track.tv_episode,
          # tv_episode_number: track.tv_episode_number,
          # tv_network_name: track.tv_network_name,
          # tv_season: track.tv_season,
          # tv_show_name: track.tv_show_name,
          year: '2014'
        }
      end

      it "returns a hash populated with MP4 attributes values" do
        expect(track.attributes).to eq(attribute_hash)
      end
    end
  end
end
