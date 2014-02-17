require 'aoede/attributes/base'

module Aoede
  module Attributes
    module FileRef
      include Aoede::Attributes::Base

      ATTRIBUTES = [:album, :artist, :comment, :genre, :title, :track, :year]

      # @return [Hash]
      def attributes
        attrs = Hash.new

        ATTRIBUTES.each do |key|
          attrs[key] = audio.tag.send(value)
        end

        attrs
      end

    end
  end
end
