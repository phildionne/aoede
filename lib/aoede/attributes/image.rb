module Aoede
  module Attributes
    module Image
      extend ActiveSupport::Concern

      included do
        self.attributes += [:image]
      end

      def image
      end

      def image=(value)
      end

    end
  end
end
