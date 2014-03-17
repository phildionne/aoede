module Aoede
  class Image
    attr_accessor :data, :format, :mime_type, :width, :height

    MP4_FORMAT_MAPPING = {
      jpeg: TagLib::MP4::CoverArt::JPEG,
      png: TagLib::MP4::CoverArt::PNG
    }.with_indifferent_access.freeze

    # @param attributes [Hash]
    def initialize(attributes = {})
      attributes.each do |attr, value|
        public_send("#{attr}=", value)
      end

      self
    end

    # @return [String]
    def inspect
      string = "#<#{self.class.name}:#{self.object_id} "
      fields = instance_variables.map do |variable|
        value = instance_variable_get(variable).inspect
        # Strings with fewer than 23 chars are handled faster by MRI
        value.slice!(0..19) + '...' if value.length > 40

        # "#{variable}: #{value}"
        "#{variable}"
      end

      string << fields.join(', ') << '>'
    end

    # @return [String, Nil]
    def format
      return @format if @format
      @format = mime_type.sub(/image\//, '') if mime_type
    end

    # @param format [String, Symbol]
    # @return [String]
    def format=(format)
      @format = format.to_s
    end

    # @return [String, Nil]
    def mime_type
      return @mime_type if @mime_type
      @mime_type = "image/#{format}" if format
    end

    # @return [Hash]
    def to_hash
      hash = Hash.new

      [:data, :format, :mime_type, :width, :height].each do |attribute|
        hash[attribute] = public_send(attribute)
      end

      hash.with_indifferent_access
    end
    alias_method :to_h, :to_hash
  end
end
