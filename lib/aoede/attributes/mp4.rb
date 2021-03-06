require 'aoede/attributes/base'

module Aoede
  module Attributes
    module MP4
      include Aoede::Attributes::Base

      ATTRIBUTES += [:album_artist, :artwork, :bpm, :category, :compilation,
        :composer, :copyright, :description, :description_long, :disc_number,
        :encoded_by, :encoder, :episode_global_unique_id, :gapless_playback,
        :genre_predefined, :grouping, :lyrics, :media_type, :purchase_account,
        :purchase_date, :rating_advisory, :sort_album, :sort_album_artist,
        :sort_artist, :sort_composer, :sort_show, :sort_title, :stik, :tv_episode,
        :tv_episode_number, :tv_network, :tv_season, :tv_show_name]

      AUDIO_PROPERTIES += [:bits_per_sample]

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
        genre: '©gen',
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
          if audio.tag
            if item = audio.tag.item_list_map.fetch(atom)
              item.to_string_list.first
            end
          end
        end
      end
      module_function :define_attribute_getter

      # @param method [Symbol, String]
      # @param atom [String]
      def define_attribute_setter(method, atom)
        define_method("#{method}=") do |value|
          if audio.tag
            audio.tag.item_list_map.insert(atom, TagLib::MP4::Item.from_string_list([value]))
          else
            raise StandardError, "Audio file doesn't have a tag and value can't be set"
          end
        end
      end
      module_function :define_attribute_setter

      # @return [Image, Nil]
      def image
        return @image if @image

        if item = audio.tag.item_list_map[MAPPING[:artwork]]
          picture = item.to_cover_art_list.first
          format = Aoede::Image::MP4_FORMAT_MAPPING.find { |k, v| v == picture.format }.first
          @image = Image.new(data: picture.data, format: format)
        end
      end

      # @param image [Image]
      # @return [Image]
      def image=(image)
        picture = TagLib::MP4::CoverArt.new(Aoede::Image::MP4_FORMAT_MAPPING[image.format], image.data)
        item = TagLib::MP4::Item.from_cover_art_list([picture])

        if delete_image && audio.tag.item_list_map.insert(MAPPING[:artwork], item)
          @image = image
        end

        image
      end

      # Deletes the image
      #
      # @return [Boolean]
      def delete_image
        @image = nil
        !!audio.tag.item_list_map.erase(MAPPING[:artwork])
      end

      # Define module attributes getters and setters dynamically
      ATTRIBUTES.each do |attribute|
        define_attribute_getter(attribute, MAPPING[attribute])
        define_attribute_setter(attribute, MAPPING[attribute])
      end
    end
  end
end
