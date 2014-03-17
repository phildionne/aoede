shared_examples "image setter" do
  context "with an existing image" do
    before do
      track.image = other_image
      track.save
    end

    it "adds the right image" do
      track.image = image
      expect(track.image).to eq(image)
    end
  end

  context "without an existing image" do
    before do
      track.delete_image
      track.save
    end

    it "adds the right image" do
      track.image = image
      expect(track.image).to eq(image)
    end
  end
end


shared_examples "image getter" do
  context "with an existing image" do
    before do
      track.image = image
      track.save
    end

    it { expect(track.image).to eq(image) }
  end

  context "without an existing image" do
    before { track.delete_image }
    it { expect(track.image).to be_nil }
  end
end
