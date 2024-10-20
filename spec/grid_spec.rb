require_relative "../lib/grid"

describe Grid do
  let(:test_array) { subject.make_grid }
  describe "#make_grid" do
    it "makes an array has 80 elements including both rows and columns" do
      expect(test_array.flatten.length).to eql(80)
    end
    it "makes elemets with empty strings(' ')" do
      expect(test_array.flatten.all? { |elem| elem == " " }).to be true
    end
    it "makes an array that has 8 sub arrays" do
      expect(test_array.length).to eql(8)
    end
    it "makes an array that has 10 elements in all sub arrays" do
      expect(test_array.all? { |elem| elem.length == 10 }).to be true
    end
  end

  describe "#assign_grid" do
    let(:test_array) { [1, 2, 3] }
    before do
      allow(subject).to receive(:make_grid).and_return(test_array)
    end
    it "assigns array to instance variable grid" do
      subject.assign_grid
      expect(subject.instance_variable_get(:@grid)).to eql(test_array)
    end
  end
end
