require 'spec_helper'

describe Aoede::Attributes::Ogg do
  let(:filename_ogg)  { File.expand_path('Test - Track.ogg', 'spec/support/') }
  let(:track) { Aoede::Track.new(filename_ogg) }

  describe :ClassMethods do

    describe :extended do

      it "defines attribute getters on the receiving object" do
        Aoede::Attributes::Ogg::ATTRIBUTES.keys.each do |method|
          expect(track).to respond_to(method)
        end
      end

      it "defines attribute setters on the receiving object" do
        Aoede::Attributes::Ogg::ATTRIBUTES.keys.each do |method|
          expect(track).to respond_to("#{method}=")
        end
      end
    end
  end
end
