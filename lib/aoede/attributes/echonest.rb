module Aoede
  module Attributes
    module EchoNest
      extend ActiveSupport::Concern

      included do
      end

      def fingerprint
        @fingerprint ||= Proc.new do
          # 20 seconds of sound, starting at 10 sec
          results = JSON.parse(`echoprint-codegen "#{filename}" 10 20`)
          results.first['code']
        end.call
      end
    end
  end
end
