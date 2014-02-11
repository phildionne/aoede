module Aoede
  module Attributes
    module Base
      extend ActiveSupport::Concern

      included do
        self.attributes += [:artist, :album_artist, :comment, :genre, :release,
                   :release_year, :title, :tracknum]
      end

      # @return [String, Nil]
      def artist
        audio.tag.try(:artist)
      end

      # @param value [String]
      def artist=(value)
      end

      # @return [String, Nil]
      def album_artist
        audio.id3v2_tag.frame_list('TPE2').first.try(:to_string)
      end

      # @param value [String]
      def album_artist=(value)
      end

      # @return [String, Nil]
      def comment
        audio.tag.try(:comment)
      end

      # @param value [String]
      def comment=(value)
      end

      # @return [String, Nil]
      def genre
        audio.tag.try(:genre)
      end

      # @param value [String]
      def genre=(value)
      end

      # @return [String, Nil]
      def release
        # Doesn't seem to work
        # audio.tag.try(:album)
        audio.id3v2_tag.frame_list('TABL').first.try(:to_string)
      end

      # @param value [String]
      def release=(value)
      end

      # @return [Integer, Nil]
      def release_year
        audio.tag.try(:year)
      end

      # @param value [Integer]
      def release_year=(value)
      end

      # @return [String, Nil]
      def title
        audio.tag.try(:title) || (filename ? File.basename(filename) : nil)
      end

      # @param value [String]
      def title=(value)
      end

      # @return [Integer, Nil]
      def tracknum
        audio.tag.try(:track)
      end

      # @param value [String]
      def tracknum=(value)
      end
    end
  end
end
