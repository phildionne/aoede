require 'active_support/concern'
require 'taglib'

require 'aoede/track'

module Aoede

  # @param filename [String]
  def track(filename)
    Track.new(filename)
  end
end
