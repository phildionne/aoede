require 'active_support/core_ext'
require 'active_support/concern'
require 'taglib'

require 'aoede/library'
require 'aoede/track'

module Aoede

  # @param path [String]
  def library(path)
    Library.new(path)
  end
  module_function :library

  # @param filename [String]
  def track(filename)
    Track.new(filename)
  end
  module_function :track
end
