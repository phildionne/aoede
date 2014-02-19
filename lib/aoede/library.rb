module Aoede
  class Library
    attr_accessor :path

    # @param path [String]
    def initialize(path = nil)
      self.path = path
      self
    end

    # @return [Enumerator::Lazy]
    def files
      raise ArgumentError, "Invalid path '#{path}'" unless path.present? && File.directory?(path)

      Dir.glob([path, '/**/*'].join).lazy
        .reject { |file_path| File.directory?(file_path) }
        .grep(/(.mp3|.mp4|.m4a|.m4p|.m4b|.m4r|.m4v|.oga|.ogg|.flac)/)
    end

    # @return [Enumerator::Lazy]
    def tracks
      files.map { |file| Aoede::Track.new(file) }
    end

    # @param attributes [Hash]
    # @return [Enumerator::Lazy]
    def find_by(attributes = {})
      tracks.select do |track|
        attributes.all? do |attribute, value|
          track.try(attribute) == value
        end
      end
    end
  end
end
