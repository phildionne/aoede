module Aoede
  module Attributes
    module Base
      extend ActiveSupport::Concern

      module ClassMethods

        def define_attribute_getters
          self::ATTRIBUTES.keys.each do |method|
            send(:define_method, method) do
              attributes[method]
            end
          end
        end

        def define_attribute_setters
          raise NotImplementedError
        end

        private :define_attribute_setters, :define_attribute_getters
      end
    end
  end
end
