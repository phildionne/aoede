require 'aoede/attributes/base'

module Aoede
  module Attributes
    module Ogg
      include Aoede::Attributes::Base

      AUDIO_PROPERTIES += [:bitrate_maximum, :bitrate_minimum, :bitrate_nominal, :vorbis_version]

      def vendor_id
        audio.xiph_comment.vendor_id
      end
    end
  end
end
