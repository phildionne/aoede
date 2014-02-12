module Aoede
  module Attributes
    module MP4

      ATTRIBUTES = {
        album: "©alb",
        album_artist: "aART",
        artist: "©art",
        artwork: "covr",
        bpm: "tmpo",
        category: "catg",
        comment: "©cmt",
        compilation: "cpil",
        composer: "©wrt",
        copyright: "cprt",
        description: "desc",
        disk_number: "disk",
        encoder: "©too",
        episode_global_unique_id: "egid",
        gapless_playback: "pgap",
        genre: "©gen",
        grouping: "©grp",
        keyword: "keyw",
        lyrics: "©lyr",
        podcast: "pcst",
        podcast_url: "purl",
        purchase_date: "purd",
        rating_advisory: "rtng",
        sort_album: "soal",
        sort_album_artist: "soaa",
        sort_artist: "soar",
        sort_composer: "soco",
        sort_title: "sonm",
        stik: "stik",
        title: "©nam",
        track_number: "trkn",
        tv_episode: "tves",
        tv_episode_number: "tven",
        tv_network_name: "tvnn",
        tv_season: "tvsn",
        tv_show_name: "tvsh",
        year: "©day"
      }

      # @param audio [TagLib::MP4::File]
      # @return [Hash]
      def self.attributes(audio)
        attrs = Hash.new

        ATTRIBUTES.each do |key, value|
          item = audio.tag.item_list_map.fetch(value)

          if item
            attrs[key] = item.to_string_list.first
          end
        end

        attrs
      end

    end
  end
end
