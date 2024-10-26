# frozen_string_literal: true

require_relative '../lib/connect_four'

describe ConnectFour do
  let(:player1) { double('Player', name: 'Adam', symbol: 'X') }
  let(:player2) { double('Player') }
  subject { described_class.new(player1, player2) }
  describe '#user_input' do
    context 'when user chooses a valid number' do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return('4')
      end
      it 'assigns user input to choice variable' do
        expect(subject).to receive(:gets).and_return('4')
        choice = subject.user_input(player1)
        expect(choice).to eql(4)
      end
    end
    context 'when user chooses an invalid number' do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return('11', '3')
        allow(subject).to receive(:puts).with('invalid choice, the number should be between 1 -10')
      end
      it 'prints error message' do
        expect(subject).to receive(:puts).with('invalid choice, the number should be between 1 -10').once
        subject.user_input(player1)
      end
    end
    context 'when user chooses a invalid number' do
      before do
        allow(subject).to receive(:puts)
        allow(subject).to receive(:gets).and_return('11', '2')
      end
      it 'prompts user to choose again until a valid choice is made' do
        expect(subject).to receive(:gets).twice
        subject.user_input(player1)
      end
    end
  end

  describe '#turn' do
    context "when the grid isn't full and update_grid returns true" do
      before do
        allow(subject).to receive(:user_input).and_return(2)
        allow(subject).to receive(:puts)
        allow(subject).to receive(:update_grid?).and_return(true)
      end
      it 'displays grid' do
        expect(subject.instance_variable_get(:@board)).to receive(:display_grid)
        subject.turn(player1)
      end
    end
    context "when the grid isn't full and update_grid returns true" do
      before do
        allow(subject).to receive(:user_input).and_return(2)
        allow(subject).to receive(:puts)
        allow(subject).to receive(:update_grid?).and_return(true)
        allow(subject.board).to receive(:display_grid)
      end
      it 'invokes user_input just once' do
        expect(subject).to receive(:user_input).once
        subject.turn(player1)
      end
    end
    context 'when the grid is full and update_grid returns false' do
      before do
        allow(subject).to receive(:user_input).and_return(2)
        allow(subject).to receive(:puts)
        allow(subject).to receive(:update_grid?).and_return(false, true)
        allow(subject.board).to receive(:display_grid)
      end
      it 'calls user input method again' do
        expect(subject).to receive(:user_input).twice
        subject.turn(player1)
      end
    end
  end

  describe '#update_grid' do
    let(:board) { subject.instance_variable_get(:@board) }
    context "when user selects first column and there's no other symbols in the column" do
      before do
        allow(subject).to receive(:user_input).and_return(0)
        board.grid = [Array.new(8, ' ')]
      end
      it 'updates the bottom cell of the grid with player symbol' do
        grid_array = subject.board.grid
        subject.update_grid?(subject.user_input(player1), player1)
        expect(grid_array[0][7]).to eql('X')
      end
    end
    context 'when user selects first column and the column is full' do
      before do
        allow(subject).to receive(:user_input).and_return(0)
        allow(subject).to receive(:puts)
        board.grid = [Array.new(8, 'X')]
      end
      it 'returns nil' do
        expect(subject.update_grid?(subject.user_input(player1), player1)).to be_nil
      end
    end
    context "when user selects first column and there's no other symbols in the column" do
      before do
        allow(subject).to receive(:user_input).and_return(0)
        board.grid = [Array.new(8, ' ')]
      end
      it 'returns true' do
        expect(subject.update_grid?(subject.user_input(player1), player1)).to be true
      end
    end
    context "when user selects third column and there's no other symbols in the column" do
      before do
        allow(subject).to receive(:user_input).and_return(2)
        board.grid = [Array.new(8, ' '), Array.new(8, ' '), Array.new(8, ' ')]
      end
      it 'updates the bottom cell of the grid with player symbol' do
        grid_array = subject.board.grid
        subject.update_grid?(subject.user_input(player1), player1)
        expect(grid_array[2][7]).to eql('X')
      end
    end
    context 'when user selects third column and the column has two symbols' do
      before do
        allow(subject).to receive(:user_input).and_return(2)
        board.grid = [Array.new(8, ' '), Array.new(8, ' '), [' ', ' ', ' ', ' ', ' ', ' ', 'X', 'X']]
      end
      it 'updates the bottom third element in the column' do
        grid_array = subject.board.grid
        subject.update_grid?(subject.user_input(player1), player1)
        expect(grid_array[2][5]).to eql('X')
      end
    end
  end

  # describe '#check_winner?' do
  #   context 'when either of the player connects four vertically' do
  #     it 'returns true' do
  #       expect(subject.check_winner?).to be true
  #     end
  #   end
  # end

  describe '#slected_column_cell_index' do
    let(:board) { double('Board', grid: [Array.new(8), [' ', ' ', ' ', ' ', ' ', ' ', 'X', 'X']]) }
    before do
      allow(subject).to receive(:user_input).and_return(1)
      subject.board = board.grid
    end
    it 'returns the cell selected by user via column selection' do
      cell_index = subject.selected_column_cell_index(subject.user_input(player1), board.grid)
      expect(cell_index).to eql(6)
    end
  end

  describe '#vertical_check?' do
    context 'when either of the player connects four vertically' do
      it 'returns true' do
        input = 0
        grid = [[' ', ' ', ' ', ' ', 'X', 'X', 'X', 'X']]
        expect(subject.vertical_check?(input, grid, player1)).to be true
      end
    end

    context "when connect four doesen't happen" do
      it 'returns false' do
        input = 0
        grid = [[' ', ' ', ' ', ' ', 'X', 'O', 'X', 'X']]
        expect(subject.vertical_check?(input, grid, player1)).to be false
      end
    end
  end

  describe '#horizontal_check?' do
    context 'when one of the players connects horizonatlly' do
      it 'returns true' do
        input = 2
        grid = [[' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X'],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X'],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X'],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X'],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X'],
                Array.new(8, ' '), Array.new(8, ' ')]
        expect(subject.horizontal_check?(input, grid, player1)).to be true
      end
    end
    context 'when the players do not connect horizonatlly' do
      it 'returns false' do
        input = 3
        grid = [[' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X'],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X'],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X'],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X'],
                Array.new(8, ' '), Array.new(8, ' ')]
        expect(subject.horizontal_check?(input, grid, player1)).to be false
      end
    end
  end

  describe '#diagonal_check?' do
    context 'when one of the players connect diagonally upwards' do
      it 'returns true' do
        input = 4
        grid = [[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' ', ' ', 'X', ' ', ' '],
                [' ', ' ', ' ', ' ', 'X', ' ', ' ', 'X'],
                [' ', ' ', ' ', 'X', ' ', ' ', ' ', 'X'],
                [' ', ' ', 'X', ' ', ' ', ' ', ' ', 'X']]
        expect(subject.diagonal_check?(input, grid, player1)).to be true
      end
    end

    context 'when one of the players connect diagonally downwards' do
      it 'returns true' do
        input = 2
        grid = [[' ', ' ', ' ', 'X', ' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' ', 'X', ' ', ' ', ' '],
                [' ', ' ', ' ', ' ', ' ', 'X', ' ', ' '],
                [' ', ' ', ' ', ' ', ' ', ' ', 'X', 'X'],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X'],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X']]
        expect(subject.diagonal_check?(input, grid, player1)).to be true
      end
    end

    context 'when the players do not connect diagonally' do
      it 'returns false' do
        input = 2
        grid = [[' ', ' ', ' ', 'X', ' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' ', ' ', 'X', ' ', ' '],
                [' ', ' ', ' ', ' ', ' ', ' ', 'X', 'X'],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X'],
                [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X']]
        expect(subject.diagonal_check?(input, grid, player1)).to be false
      end
    end
  end
end
