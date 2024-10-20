require_relative "../lib/connect_four"

describe ConnectFour do
  let(:player1) { double("Player") }
  let(:player2) { double("Player") }
  subject { described_class.new(player1, player2) }
  describe "#user_input" do
    context "when user chooses a valid number" do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return("4")
      end
      it "assigns user input to choice variable" do
        expect(subject).to receive(:gets).and_return("4")
        choice = subject.user_input
        expect(choice).to eql(4)
      end
    end
    context "when user chooses an invalid number" do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return("11", "3")
        allow(subject).to receive(:puts).with("invalid choice, please choose a number between 1 - 10")
      end
      it "prints error message" do
        expect(subject).to receive(:puts).with("invalid choice, please choose a number between 1 - 10").once
        subject.user_input
      end
    end
    context "when user chooses a invalid number" do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return("11", "2")
      end
      it "prompts user to choose again until a valid choice is made" do
        expect(subject).to receive(:gets).twice
        subject.user_input
      end
    end
  end
end
