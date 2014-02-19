module Aoede
  module Attributes

    # @abstract Include in any format specific module
    module Base
      extend ActiveSupport::Concern

      ATTRIBUTES = [:album, :artist, :comment, :genre, :title, :track, :year]
      MAPPING = Hash.new

      # @return [Hash]
      def attributes
        attrs = Hash.new

        self.singleton_class::ATTRIBUTES.each do |attribute|
          if value = send(attribute)
            attrs[attribute] = value
          end
        end

        attrs
      end
    end
  end
end
