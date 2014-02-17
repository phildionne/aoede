require 'aoede/attributes/base'

module Aoede
  module Attributes
    module MPEG
      include Aoede::Attributes::Base

      ATTRIBUTES = {
        album: 'TALB',
        album_artist: 'TPE2',
        arranger: 'TPE4',
        artist: 'TPE1:',
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
        filename: 'TOFN',
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
        release_time: 'TDRL',
        set_subtitle: 'TSST',
        sort_album: 'TSO2',
        sort_album: 'TSOA',
        sort_composer: 'TSOC',
        sort_performer: 'TSOP',
        sort_title: 'TSOT',
        tagging_time: 'TDTG',
        time: 'TIME',
        title: 'TIT2',
        track: 'TRCK',
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
        wwwsource: 'WOAS',
        year: 'TDRC'
      }.freeze

      # Defines MPEG attribute setter on the passed instance
      #
      # @param instance [Aoede::Track]
      # @param method [Symbol, String]
      def self.define_attribute_setter(instance, method)
        instance.send(:define_singleton_method, "#{method}=") do |value|
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
            raise # FIXME Should never happen
          end

          audio.id3v2_tag.add_frame(frame)
        end
      end

      # @return [Hash]
      def attributes
        attrs = Hash.new

        ATTRIBUTES.each do |key, value|
          frames = audio.id3v2_tag.frame_list(value)

          if frames.any?
            item = frames.first

            case
            when item.is_a?(::TagLib::ID3v2::CommentsFrame) || item.is_a?(::TagLib::ID3v2::UserTextIdentificationFrame) || item.is_a?(::TagLib::ID3v2::UserUrlLinkFrame) || item.is_a?(::TagLib::ID3v2::UnsynchronizedLyricsFrame)
              attrs[key] = item.text
            when item.is_a?(::TagLib::ID3v2::UrlLinkFrame)
              attrs[key] = item.url
            else
              attrs[key] = item.field_list.first unless item.field_list.first.blank?
            end
          end
        end

        attrs
      end

    end
  end
end
