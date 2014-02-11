module Aoede
  module Attributes
    module Itunes
      extend ActiveSupport::Concern

      included do
        self.attributes += [:composer, :sort_title, :sort_artist, :sort_album_artist, :sort_composer]
      end

      # @return [String, Nil]
      def composer
        audio.id3v2_tag.frame_list('TCOM').first.try(:to_string)
      end

      def composer=(value)
      end

      # @return [String, Nil]
      def sort_title
        audio.id3v2_tag.frame_list('TSOT').first.try(:to_string) # ID3v2.4
      end

      def sort_title=(value)
      end

      # @return [String, Nil]
      def sort_artist
        audio.id3v2_tag.frame_list('TSOA').first.try(:to_string) # ID3v2.4
      end

      def sort_artist=(value)
      end

      # @return [String, Nil]
      def sort_album_artist
        audio.id3v2_tag.frame_list('TSOP').first.try(:to_string) # ID3v2.4
      end

      def sort_album_artist=(value)
      end

      # @return [String, Nil]
      def sort_composer
        audio.id3v2_tag.frame_list('TSOC').first.try(:to_string) # ID3v2.4
      end

      def sort_composer=(value)
      end
    end
  end
end
