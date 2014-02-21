require 'aoede/image'
require 'aoede/attributes/mp4'
require 'aoede/attributes/mpeg'
require 'aoede/attributes/flac'
require 'aoede/attributes/ogg'

module Aoede
  class Track
    attr_accessor :options
    attr_reader :filename

    # @param filename [String]
    def initialize(filename, options = {})
      raise ArgumentError, "No such file: '#{filename}'" unless File.exist?(filename)

      options = options.reverse_merge({
        audio_properties: true
      })

      @options = options
      @filename = filename

      case filename
      when /\.(mp4|m4a|m4p|m4b|m4r|m4v)\z/
        extend Aoede::Attributes::MP4
      when /\.(oga|ogg)\z/
        extend Aoede::Attributes::Ogg
      when /\.flac\z/
        extend Aoede::Attributes::Flac
      when /\.mp3\z/
        extend Aoede::Attributes::MPEG
      else
        self.singleton_class.send(:include, Aoede::Attributes::Base)
      end

      self
    end

    # @return [TagLib::FileRef, TagLib::MP4::File, TagLib::MPEG::File, TagLib::FLAC::File, TagLib::Ogg::Vorbis::File]
    def audio
      @audio ||= case filename
        when /\.(mp4|m4a|m4p|m4b|m4r|m4v)\z/
          TagLib::MP4::File.new(filename, options[:audio_properties])
        when /\.(oga|ogg)\z/
          TagLib::Ogg::Vorbis::File.new(filename, options[:audio_properties])
        when /\.flac\z/
          TagLib::FLAC::File.new(filename, options[:audio_properties])
        when /\.mp3\z/
          TagLib::MPEG::File.new(filename, options[:audio_properties])
        else
          TagLib::FileRef.new(filename, options[:audio_properties])
        end
    end

    # @param attrs [Hash]
    # @return [Boolean]
    def update(attrs)
      attrs.each do |attr, value|
        public_send("#{attr}=", value)
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
      attributes.with_indifferent_access
    end
    alias_method :to_h, :to_hash
  end
end
