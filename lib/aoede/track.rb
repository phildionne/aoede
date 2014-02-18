require 'aoede/attributes/mp4'
require 'aoede/attributes/mpeg'
require 'aoede/attributes/flac'
require 'aoede/attributes/ogg'
require 'aoede/attributes/fileref'

module Aoede
  class Track
    attr_reader :filename

    # @param filename [String]
    def initialize(filename)
      raise ArgumentError, "No such file: '#{filename}'" unless File.exist?(filename)
      @filename = filename

      case
      when audio.is_a?(::TagLib::MP4::File)
        extend Aoede::Attributes::MP4
      when audio.is_a?(::TagLib::MPEG::File)
        extend Aoede::Attributes::MPEG
      when audio.is_a?(::TagLib::FLAC::File)
        extend Aoede::Attributes::Flac
      when audio.is_a?(::TagLib::Ogg::Vorbis::File)
        extend Aoede::Attributes::Ogg
      else
        extend Aoede::Attributes::FileRef
      end

      self
    end

    # @return [TagLib::FileRef, TagLib::MP4::File, TagLib::MPEG::File, TagLib::FLAC::File, TagLib::Ogg::Vorbis::File]
    def audio
      @audio ||= case filename
                 # Do not read audio properties for faster initialization
                 # see http://rubydoc.info/gems/taglib-ruby/TagLib/FileRef:initialize
                 when /\.(mp4|m4a|m4p|m4b|m4r|m4v)\z/ then ::TagLib::MP4::File.new(filename, false)
                 when /\.(oga|ogg)\z/ then ::TagLib::Ogg::Vorbis::File.new(filename, false)
                 when /\.flac\z/      then ::TagLib::FLAC::File.new(filename, false)
                 when /\.mp3\z/       then ::TagLib::MPEG::File.new(filename, false)
                 else ::TagLib::FileRef.new(filename, false)
                 end
    end

    # @param attributes [Hash]
    # @return [Boolean]
    def update(attributes)
      attributes.each do |key, value|
        public_send("#{key}=", value)
      end

      save
    end

    # @return [Boolean]
    def save
      audio.save
    end

    # @return [Nil]
    def close
      audio.close
    end

    # @return [Hash]
    def to_hash
      attributes
    end
    alias_method :to_h, :to_hash
  end
end
