require 'aoede/attributes/base'

module Aoede
  module Attributes
    module MPEG
      include Aoede::Attributes::Base

      ATTRIBUTES = [:album, :album_artist, :arranger, :artist, :audio_delay, :audio_length,
        :audio_size, :author, :bpm, :comment, :compilation_flag, :composer, :conductor,
        :copyright, :date, :disc_number, :encoder, :encoding_settings, :encoding_time,
        :fileowner, :filetype, :genre, :grouping, :initial_key, :involved_people,
        :isrc, :language, :lyricist, :mediatype, :mood, :musician_credits,
        :organization, :original_album, :original_artist, :original_release_time,
        :original_year, :popularimeter, :produced_notice, :radio_owner,
        :radio_station_name, :recordingd_ates, :release_date, :release_time,
        :set_subtitle, :sort_album, :sort_album_artist, :sort_artist, :sort_composer,
        :sort_title, :tagging_time, :time, :title, :track_number, :ufid, :lyrics,
        :version, :wwwartist, :wwwcommercialinfo, :wwwcopyright, :wwwfileinfo,
        :wwwpayment, :wwwpublisher, :wwwradio, :wwwsource]

      AUDIO_PROPERTIES += [:copyrighted?, :layer, :original?, :protection_enabled, :version]

      MAPPING = {
        # filename: 'TOFN', Don't include, causes the overwrite of an existing method on Aoede::Track
        album: 'TALB',
        album_artist: 'TPE2',
        arranger: 'TPE4',
        artist: 'TPE1',
        audio_delay: 'TDLY',
        audio_length: 'TLEN',
        audio_size: 'TSIZ',
        author: 'TOLY',
        bpm: 'TBPM',
        comment: 'COMM',
        compilation_flag: 'TCMP',
        composer: 'TCOM',
        conductor: 'TPE3',
        copyright: 'TCOP',
        date: 'TDAT',
        disc_number: 'TPOS',
        encoder: 'TENC',
        encoding_settings: 'TSSE',
        encoding_time: 'TDEN',
        fileowner: 'TOWN',
        filetype: 'TFLT',
        genre: 'TCON',
        grouping: 'TIT1',
        initial_key: 'TKEY',
        involved_people: 'TIPL',
        isrc: 'TSRC',
        language: 'TLAN',
        lyricist: 'TEXT',
        mediatype: 'TMED',
        mood: 'TMOO',
        musician_credits: 'TMCL',
        organization: 'TPUB',
        original_album: 'TOAL',
        original_artist: 'TOPE',
        original_release_time: 'TDOR',
        original_year: 'TORY',
        popularimeter: 'POPM',
        produced_notice: 'TPRO',
        radio_owner: 'TRSO',
        radio_station_name: 'TRSN',
        recordingd_ates: 'TRDA',
        release_date: 'TDRC',
        release_time: 'TDRL',
        set_subtitle: 'TSST',
        sort_album: 'TSOA',
        sort_album_artist: 'TSO2',
        sort_artist: 'TSOP',
        sort_composer: 'TSOC',
        sort_title: 'TSOT',
        tagging_time: 'TDTG',
        time: 'TIME',
        title: 'TIT2',
        track_number: 'TRCK',
        ufid: 'UFID',
        lyrics: 'USLT',
        version: 'TIT3',
        wwwartist: 'WOAR',
        wwwcommercialinfo: 'WCOM',
        wwwcopyright: 'WCOP',
        wwwfileinfo: 'WOAF',
        wwwpayment: 'WPAY',
        wwwpublisher: 'WPUB',
        wwwradio: 'WORS',
        wwwsource: 'WOAS'
      }.freeze


      # TODO
      # Fallback from id3v2_tag to id3v1_tag
      # Available attributes: title, artist, album, comment, date, track_number, genre


      # @param method [Symbol, String]
      # @param frame_id [String]
      def define_attribute_getter(method, frame_id)
        define_method(method) do
          if audio.id3v2_tag
            frames = audio.id3v2_tag.frame_list(frame_id)

            if frames.any?
              item = frames.first

              text_frames = [TagLib::ID3v2::CommentsFrame, TagLib::ID3v2::UserTextIdentificationFrame,
                TagLib::ID3v2::UserUrlLinkFrame, TagLib::ID3v2::UnsynchronizedLyricsFrame]

              case
              when text_frames.any? { |frame_klass| item.is_a?(frame_klass) }
                item.text
              when item.is_a?(TagLib::ID3v2::UrlLinkFrame)
                item.url
              else
                item.to_string
              end
            else
              nil
            end
          else
            nil
          end
        end
      end
      module_function :define_attribute_getter

      # @param method [Symbol, String]
      # @param frame_id [String]
      def define_attribute_setter(method, frame_id)
        define_method("#{method}=") do |value|
          case frame_id
          when /\AT/
            frame = TagLib::ID3v2::TextIdentificationFrame.new(frame_id, TagLib::String::UTF8)
            frame.text = value
          when /\AW/
            frame = TagLib::ID3v2::UserUrlLinkFrame.new
            frame.url = value
          when /\ACOMM\z/
            frame = TagLib::ID3v2::CommentsFrame.new
            frame.text = value
          when /\AGEOB\z/
            raise NotImplementedError
          when /\APRIV\z/
            frame = TagLib::ID3v2::PrivateFrame.new
            frame.text = value
          when /\ARVAD\z/
            raise NotImplementedError
          when /\AUFID\z/
            raise NotImplementedError
          when /\AUSLT\z/
            frame = TagLib::ID3v2::UnsynchronizedLyricsFrame.new
            frame.text = value
          else
            raise StandardError, "Unrecognized MPEG frame id"
          end

          audio.id3v2_tag.add_frame(frame)
        end
      end
      module_function :define_attribute_setter

      # @return [Array]
      def images
        frames = audio.id3v2_tag.frame_list('APIC')

        frames.map do |image|
          Aoede::Image.new(data: image.picture, mime_type: image.mime_type)
        end
      end

      # @param image [Image]
      def add_image(image)
        frame = TagLib::ID3v2::AttachedPictureFrame.new

        frame.mime_type = image.mime_type
        frame.type      = TagLib::ID3v2::AttachedPictureFrame::FrontCover
        frame.picture   = image.data

        audio.id3v2_tag.add_frame(frame)
      end

      # Deletes all images
      #
      # @return [Nil]
      def delete_images
        frames = audio.id3v2_tag.frame_list('APIC')
        frames.each do |frame|
          audio.id3v2_tag.remove_frame(frame)
        end
      end

      # Define module attributes getters and setters dynamically
      ATTRIBUTES.each do |attribute|
        define_attribute_getter(attribute, MAPPING[attribute])
        define_attribute_setter(attribute, MAPPING[attribute])
      end
    end
  end
end
