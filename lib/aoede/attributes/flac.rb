require 'aoede/attributes/base'

module Aoede
  module Attributes
    module Flac
      include Aoede::Attributes::Base

      AUDIO_PROPERTIES += [:sample_width, :signature]
    end
  end
end
