module Aoede

  class Track
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
  end
end
