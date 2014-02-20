require 'spec_helper'

describe Aoede::Attributes::Base do
  let(:filename) { File.expand_path('Test - Track.wav', 'spec/support/') }
  let(:track) { Aoede::Track.new(filename) }

  describe :ClassMethods do

    describe :included do

      it "defines attribute getters on the receiving object" do
        Aoede::Attributes::Base::ATTRIBUTES.each do |method|
          expect(track).to respond_to(method)
        end
      end

      it "defines attribute setters on the receiving object" do
        Aoede::Attributes::Base::ATTRIBUTES.each do |method|
          expect(track).to respond_to("#{method}=")
        end
      end
    end
  end

  describe :InstanceMethods do

    describe :attributes do
      pending
    end

    describe :audio_properties do
      pending
    end
  end
end
