module Aoede
  class Library
    attr_accessor :path

    # @param path [String]
    def initialize(path = nil)
      self.path = path
      self
    end

    # @return [Array]
    def files
      raise ArgumentError, "Invalid path '#{path}'" unless path.present? && File.directory?(path)
      Dir.glob(File.join(path, "/**/*.{mp3,mp4,m4a,m4p,m4b,m4r,m4v,oga,ogg,flac}"))
    end

    # @return [Array]
    def tracks
      files.map { |file| Aoede::Track.new(file) }
    end

    # @param attributes [Hash]
    # @return [Array]
    def select_by(attributes = {})
      tracks.select do |track|
        attributes.all? do |attribute, value|
          track.try(attribute) == value
        end
      end
    end
  end
end
