module Aoede

  class Track
    attr_accessor :filename

    # @param filename [String]
    def filename=(filename)
      raise ArgumentError, "No such file: #{filename}" unless File.exist?(filename)
      @filename = filename
    end
  end
end
