require_relative "../lib/connect_four"

describe ConnectFour do
  let(:player1) { double("Player", name: "Adam", symbol: "X") }
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

  describe "#turn" do
    context "when the grid isn't full and update_grid returns true" do
      before do
        allow(subject).to receive(:user_input).and_return(2)
        allow(subject).to receive(:puts)
        allow(subject).to receive(:update_grid?).and_return(true)
      end
      it "displays grid" do
        expect(subject.instance_variable_get(:@board)).to receive(:display_grid)
        subject.turn(player1)
      end
    end
    context "when the grid is full and update_grid returns false" do
      before do
        allow(subject).to receive(:user_input).and_return(2)
        allow(subject).to receive(:puts)
        allow(subject).to receive(:update_grid?).and_return(false, true)
        allow(subject.board).to receive(:display_grid)
      end
      it "calls user input method again" do
        expect(subject).to receive(:user_input).twice
        subject.turn(player1)
      end
    end
  end

  describe "#update_grid" do
    let(:board) { subject.instance_variable_get(:@board) }
    context "when user selects first column and there's no other symbols in the column" do
      before do
        allow(subject).to receive(:user_input).and_return(0)
        board.grid = [Array.new(8, " ")]
      end
      it "updates the bottom cell of the grid with player symbol" do
        grid_array = subject.board.grid
        subject.update_grid?(subject.user_input, player1)
        expect(grid_array[0][7]).to eql("X")
      end
    end
    context "when user selects first column and the column is full" do
      before do
        allow(subject).to receive(:user_input).and_return(0)
        allow(subject).to receive(:puts)
        board.grid = [Array.new(8, "X")]
      end
      it "returns nil" do
        expect(subject.update_grid?(subject.user_input, player1)).to be_nil
      end
    end
    context "when user selects first column and there's no other symbols in the column" do
      before do
        allow(subject).to receive(:user_input).and_return(0)
        board.grid = [Array.new(8, " ")]
      end
      it "returns true" do
        expect(subject.update_grid?(subject.user_input, player1)).to be true
      end
    end
    context "when user selects third column and there's no other symbols in the column" do
      before do
        allow(subject).to receive(:user_input).and_return(2)
        board.grid = [Array.new(8, " "), Array.new(8, " "), Array.new(8, " ")]
      end
      it "updates the bottom cell of the grid with player symbol" do
        grid_array = subject.board.grid
        subject.update_grid?(subject.user_input, player1)
        expect(grid_array[2][7]).to eql("X")
      end
    end
    context "when user selects third column and the column has two symbols" do
      before do
        allow(subject).to receive(:user_input).and_return(2)
        board.grid = [Array.new(8, " "), Array.new(8, " "), [" ", " ", " ", " ", " ", " ", "X", "X"]]
      end
      it "updates the bottom third element in the column" do
        grid_array = subject.board.grid
        subject.update_grid?(subject.user_input, player1)
        expect(grid_array[2][5]).to eql("X")
      end
    end
  end
end
