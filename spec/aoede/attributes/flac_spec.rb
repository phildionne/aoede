require 'spec_helper'

describe Aoede::Attributes::Flac do
  let(:filename_flac)  { File.expand_path('Test - Track.flac', 'spec/support/') }
  let(:track) { Aoede::Track.new(filename_flac) }

  describe :ClassMethods do

    describe :extended do

      it "defines attribute getters on the receiving object" do
        Aoede::Attributes::Flac::ATTRIBUTES.keys.each do |method|
          expect(track).to respond_to(method)
        end
      end

      it "defines attribute setters on the receiving object" do
        Aoede::Attributes::Flac::ATTRIBUTES.keys.each do |method|
          expect(track).to respond_to("#{method}=")
        end
      end
    end
  end
end
