require 'aoede/attributes/base'
require 'aoede/attributes/image'

module Aoede
  class Track
    include Aoede::Attributes::Base
    include Aoede::Attributes::Image
    include Aoede::Attributes::EchoNest

    attr_accessor :filename

    # @param filename [String]
    def initialize(filename)
      raise ArgumentError, "No such file: #{filename}" unless File.exist?(filename)
      @filename = filename

      define_attribute_methods!

      self
    end

    # @return [TagLib::FileRef, TagLib::MP4::File, TagLib::MPEG::File, TagLib::FLAC::File, TagLib::OGG::Vorbis::File]
    def audio
      @audio ||= case filename
                 # Do not read audio properties for faster initialization
                 # see http://rubydoc.info/gems/taglib-ruby/TagLib/FileRef:initialize
                 when /\.mp4\z/  then ::TagLib::MP4::File.new(filename, false)
                 when /\.mp3\z/  then ::TagLib::MPEG::File.new(filename, false)
                 when /\.flac\z/ then ::TagLib::FLAC::File.new(filename, false)
                 when /\.oga\z/  then ::TagLib::OGG::Vorbis::File.new(filename, false)
                 else ::TagLib::FileRef.new(filename, false)
                 end
    end

    # @param attributes [Hash]
    # @return [Hash]
    def update(attributes)
      attributes.each do |key, value|
        public_send("#{key}=", value)
      end

      save
      attributes
    end

    # @return [Boolean]
    def save
      audio.save && audio.close
    end

    # @return [Hash]
    def to_hash
      attributes
    end
    alias_method :to_h, :to_hash
  end
end
