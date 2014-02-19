require 'aoede/attributes/base'

module Aoede
  module Attributes
    module MPEG
      include Aoede::Attributes::Base

      ATTRIBUTES = {
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
        unsynced_lyrics: 'USLT',
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
          frames = audio.id3v2_tag.frame_list(frame_id)

          if frames.any?
            item = frames.first

            case
            when item.is_a?(::TagLib::ID3v2::CommentsFrame) || item.is_a?(::TagLib::ID3v2::UserTextIdentificationFrame) || item.is_a?(::TagLib::ID3v2::UserUrlLinkFrame) || item.is_a?(::TagLib::ID3v2::UnsynchronizedLyricsFrame)
              item.text
            when item.is_a?(::TagLib::ID3v2::UrlLinkFrame)
              item.url
            else
              item.field_list.first
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
          when /\AAPIC\z/
            raise NotImplementedError
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

      # Define module attributes getters and setters dynamically
      ATTRIBUTES.each do |method, mapping|
        define_attribute_getter(method, mapping)
        define_attribute_setter(method, mapping)
      end
    end
  end
end
