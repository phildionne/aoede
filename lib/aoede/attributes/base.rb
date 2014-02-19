module Aoede
  module Attributes

    # @abstract Include in any format specific module
    module Base
      extend ActiveSupport::Concern

      ATTRIBUTES = Hash.new

      # @return [Hash]
      def attributes
        attrs = Hash.new

        self.singleton_class::ATTRIBUTES.keys.each do |attribute|
          attrs[attribute] = send(attribute)
        end

        attrs
      end
    end
  end
end
