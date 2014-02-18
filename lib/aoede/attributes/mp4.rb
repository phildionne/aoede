require 'aoede/attributes/base'

module Aoede
  module Attributes
    module MP4
      include Aoede::Attributes::Base

      ATTRIBUTES = {
        album: '©alb',
        album_artist: 'aART', # FIXME
        artist: '©art',       # FIXME
        artwork: 'covr',
        bpm: 'tmpo',
        category: 'catg',
        comment: '©cmt',
        compilation: 'cpil',
        composer: '©wrt',
        copyright: 'cprt',
        description: 'desc',
        disk_number: 'disk',
        encoder: '©too',
        episode_global_unique_id: 'egid',
        gapless_playback: 'pgap',
        genre: '©gen',
        grouping: '©grp',
        keyword: 'keyw',
        lyrics: '©lyr',
        podcast: 'pcst',
        podcast_url: 'purl',
        purchase_date: 'purd',
        rating_advisory: 'rtng',
        sort_album: 'soal',
        sort_album_artist: 'soaa',
        sort_artist: 'soar',
        sort_composer: 'soco',
        sort_title: 'sonm',
        stik: 'stik',
        title: '©nam',
        track_number: 'trkn',
        tv_episode: 'tves',
        tv_episode_number: 'tven',
        tv_network_name: 'tvnn',
        tv_season: 'tvsn',
        tv_show_name: 'tvsh',
        year: '©day'
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
      ATTRIBUTES.each do |method, mapping|
        define_attribute_getter(method, mapping)
        define_attribute_setter(method, mapping)
      end
    end
  end
end
