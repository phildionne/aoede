module Aoede
  module Attributes

    # @abstract Include in any format specific module
    module Base
      extend ActiveSupport::Concern

      ATTRIBUTES = Hash.new

      module ClassMethods

        # Extended hook defining attributes getter and setter on the passed instance
        #
        # @param instance [Aoede::Track]
        def extended(instance)
          self::ATTRIBUTES.keys.each do |method|
            # Don't create a setter for an attribute that would overwrite an existing method
            next if instance.singleton_class.method_defined?(method)
            define_attribute_getter(instance, method)

            # Don't create a setter for an attribute that would overwrite an existing method
            next if instance.singleton_class.method_defined?("#{method}=")
            define_attribute_setter(instance, method)
          end
        end

        # Defines attribute setter on the passed instance
        #
        # @param instance [Aoede::Track]
        # @param method [Symbol, String]
        def define_attribute_getter(instance, method)
          instance.send(:define_singleton_method, method) do
            attributes[method]
          end
        end

        # Defines attribute setter on the passed instance
        #
        # @param instance [Aoede::Track]
        # @param method [Symbol, String]
        def define_attribute_setter(instance, method)
          raise NotImplementedError
        end

        private :define_attribute_setter, :define_attribute_getter
      end

      def attributes
        raise NotImplementedError
      end
    end
  end
end
