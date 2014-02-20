require 'aoede/attributes/base'

module Aoede
  module Attributes
    module Ogg
      include Aoede::Attributes::Base

      AUDIO_PROPERTIES += [:bitrate_maximum, :bitrate_minimum, :bitrate_nominal, :vorbis_version]
    end
  end
end
