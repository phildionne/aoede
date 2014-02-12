module Aoede
  module Attributes
    module MPEG

      ATTRIBUTES = {
        album: "TALB",
        album_artist: "TPE2",
        arranger: "TPE4",
        artist: "TPE1:",
        audio_delay: "TDLY",
        audio_length: "TLEN",
        audio_size: "TSIZ",
        author: "TOLY",
        bpm: "TBPM",
        comment: "COMM",
        compilation_flag: "TCMP",
        composer: "TCOM",
        conductor: "TPE3",
        copyright: "TCOP",
        date: "TDAT",
        disc_number: "TPOS",
        encoder: "TENC",
        encoding_settings: "TSSE",
        encoding_time: "TDEN",
        filename: "TOFN",
        fileowner: "TOWN",
        filetype: "TFLT",
        genre: "TCON",
        grouping: "TIT1",
        initial_key: "TKEY",
        involved_people: "TIPL",
        isrc: "TSRC",
        language: "TLAN",
        lyricist: "TEXT",
        mediatype: "TMED",
        mood: "TMOO",
        musician_credits: "TMCL",
        organization: "TPUB",
        original_album: "TOAL",
        original_artist: "TOPE",
        original_release_time: "TDOR",
        original_year: "TORY",
        popularimeter: "POPM",
        produced_notice: "TPRO",
        radio_owner: "TRSO",
        radio_station_name: "TRSN",
        recordingd_ates: "TRDA",
        release_time: "TDRL",
        set_subtitle: "TSST",
        sort_album: "TSO2",
        sort_album: "TSOA",
        sort_composer: "TSOC",
        sort_performer: "TSOP",
        sort_title: "TSOT",
        tagging_time: "TDTG",
        time: "TIME",
        title: "TIT2",
        track: "TRCK",
        ufid: "UFID",
        unsynced_lyrics: "USLT",
        version: "TIT3",
        wwwartist: "WOAR",
        wwwcommercialinfo: "WCOM",
        wwwcopyright: "WCOP",
        wwwfileinfo: "WOAF",
        wwwpayment: "WPAY",
        wwwpublisher: "WPUB",
        wwwradio: "WORS",
        wwwsource: "WOAS",
        year: "TDRC"
      }

      # @param audio [TagLib::MPEG::File]
      # @return [Hash]
      def self.attributes(audio)
        attrs = Hash.new

        ATTRIBUTES.each do |key, value|
          frames = audio.id3v2_tag.frame_list(value)

          if frames.any?
            item = frames.first

            case
            when item.is_a?(TagLib::ID3v2::CommentsFrame)
              attrs[key] = item.description
            when item.is_a?(TagLib::ID3v2::UniqueFileIdentifierFrame)
              attrs[key] = item.identifier
            else
              attrs[key] = item.field_list.first
            end
          end
        end

        attrs
      end

    end
  end
end
