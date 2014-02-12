module Aoede
  module Attributes
    module FileRef
      ATTRIBUTES = [:album, :artist, :comment, :genre, :title, :track, :year]

      # @param audio [TagLib::FileRef]
      # @return [Hash]
      def self.attributes(audio)
        attrs = Hash.new

        ATTRIBUTES.each do |key|
          attrs[key] = audio.tag.send(value)
        end

        attrs
      end

    end
  end
end
