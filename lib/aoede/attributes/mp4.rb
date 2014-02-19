require 'aoede/attributes/base'

module Aoede
  module Attributes
    module MP4
      include Aoede::Attributes::Base

      ATTRIBUTES = [:album, :album_artist, :artist, :artwork, :bpm, :category,
        :comment, :compilation, :composer, :copyright, :description, :description_long,
        :disc_number, :encoded_by, :encoder, :episode_global_unique_id,
        :gapless_playback, :genre_predefined, :genre_user, :grouping, :lyrics,
        :media_type, :purchase_account, :purchase_date, :rating_advisory,
        :release_date, :sort_album, :sort_album_artist, :sort_artist,
        :sort_composer, :sort_show, :sort_title, :stik, :title, :track_number,
        :tv_episode, :tv_episode_number, :tv_network, :tv_season, :tv_show_name]


      MAPPING = {
        album: '©alb',
        album_artist: 'aART',
        artist: '©ART',
        artwork: 'covr',
        bpm: 'tmpo',
        category: 'catg',
        comment: '©cmt',
        compilation: 'cpil',
        composer: '©wrt',
        copyright: 'cprt',
        description: 'desc',
        description_long: 'ldes',
        disc_number: 'disk',
        encoded_by: '©enc',
        encoder: '©too',
        episode_global_unique_id: 'egid',
        gapless_playback: 'pgap',
        genre_predefined: 'gnre',
        genre_user: '©gen',
        grouping: '©grp',
        lyrics: '©lyr',
        media_type: 'stik',
        purchase_account: 'apID',
        purchase_date: 'purd',
        rating_advisory: 'rtng',
        release_date: '©day',
        sort_album: 'soal',
        sort_album_artist: 'soaa',
        sort_artist: 'soar',
        sort_composer: 'soco',
        sort_show: 'sosn',
        sort_title: 'sonm',
        stik: nil,
        title: '©nam',
        track_number: 'trkn',
        tv_episode: 'tves',
        tv_episode_number: 'tven',
        tv_network: 'tvnn',
        tv_season: 'tvsn',
        tv_show_name: 'tvsh'
      }.freeze


      # @param method [Symbol, String]
      # @param atom [String]
      def define_attribute_getter(method, atom)
        define_method(method) do
          if item = audio.tag.item_list_map.fetch(atom)
            item.to_string_list.first
          end
        end
      end
      module_function :define_attribute_getter

      # @param method [Symbol, String]
      # @param atom [String]
      def define_attribute_setter(method, atom)
        define_method("#{method}=") do |value|
          audio.tag.item_list_map.insert(atom, ::TagLib::MP4::Item.from_string_list([value]))
        end
      end
      module_function :define_attribute_setter

      # Define module attributes getters and setters dynamically
      ATTRIBUTES.each do |attribute|
        define_attribute_getter(attribute, MAPPING[attribute])
        define_attribute_setter(attribute, MAPPING[attribute])
      end
    end
  end
end
