require 'aoede/attributes/mpeg'
require 'aoede/attributes/mp4'
require 'aoede/attributes/fileref'

module Aoede
  module Attributes
    module Base
      extend ActiveSupport::Concern

      # @return [Hash]
      def attributes
        case
        when audio.is_a?(::TagLib::MP4::File)
          Aoede::Attributes::MP4.attributes(audio)
        when audio.is_a?(::TagLib::MPEG::File)
          Aoede::Attributes::MPEG.attributes(audio)
        else
          Aoede::Attributes::FileRef.attributes(audio)
        end
      end


      private

      def define_attribute_methods!
        attributes.keys.each do |method|
          self.class.send(:define_method, method) do
            attributes[method]
          end
        end
      end
    end
  end
end
