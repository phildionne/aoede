require 'aoede/attributes/base'
require 'aoede/attributes/image'
require 'aoede/attributes/itunes'
require 'aoede/attributes/echonest'

module Aoede

  class Track
    include Aoede::Attributes::Base
    include Aoede::Attributes::Image
    include Aoede::Attributes::Itunes
    include Aoede::Attributes::EchoNest

    attr_accessor :filename

    # @param attributes [Hash]
    def initialize(attributes = {})
      attributes.each do |attr, value|
        self.public_send("#{attr}=", value)
      end

      self
    end

    # @param filename [String]
    def filename=(filename)
      raise ArgumentError, "No such file: #{filename}" unless File.exist?(filename)
      @filename = filename
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
  end
end
