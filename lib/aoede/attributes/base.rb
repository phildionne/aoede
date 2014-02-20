module Aoede
  module Attributes

    # @abstract Include in any format specific module
    module Base
      extend ActiveSupport::Concern

      ATTRIBUTES = [:album, :artist, :comment, :genre, :title, :track_number, :release_date]
      AUDIO_PROPERTIES = [:bitrate, :channels, :length, :sample_rate]
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

      # @return [Hash]
      def audio_properties
        return unless audio.audio_properties.present?

        properties = Hash.new

        self.singleton_class::AUDIO_PROPERTIES.each do |method|
          if value = audio.audio_properties.send(method)
            properties[method] = value
          end
        end

        properties
      end

      # @param method_name [Symbol, String]
      # @param method [Symbol, String]
      def define_attribute_getter(method_name, method)
        define_method(method_name) do
          audio.tag.send(method)
        end
      end
      module_function :define_attribute_getter

      # @param method_name [Symbol, String]
      # @param method [Symbol, String]
      def define_attribute_setter(method_name, method)
        define_method("#{method_name}=") do |value|
          audio.tag.send("#{method}=", value)
        end
      end
      module_function :define_attribute_setter

      # Define module attributes getters and setters dynamically
      ATTRIBUTES.each do |method_name|
        mapping = {
          track_number: :track,
          release_date: :year
        }

        method = mapping[method_name] ? mapping[method_name] : method_name

        define_attribute_getter(method_name, method)
        define_attribute_setter(method_name, method)
      end
    end
  end
end
