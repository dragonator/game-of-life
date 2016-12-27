require 'spec_helper'

module GameOfLife
  describe Cell do
    context '#==' do
      it 'can compare using #==' do
        cell1 = Cell.new 0, 0, :board
        cell2 = Cell.new 0, 0, :board
        expect(cell1 == cell2).to be(true)
      end
    end

    context '#eql?' do
      it 'can compare using #eql?' do
        cell1 = Cell.new 0, 0, :board
        cell2 = Cell.new 0, 0, :board
        expect(cell1.eql?(cell2)).to be(true)
      end
    end

    context '#hash' do
      it 'can generate a hash value for comparison' do
        board = Board.new [0, 0]
        cell1 = Cell.new 0, 0, board
        cell2 = Cell.new 0, 0, board
        cell3 = Cell.new 0, 0, :board
        expect(cell1.hash).to eq(cell2.hash)
        expect(cell1.hash).not_to eq(cell3.hash)
      end
    end

    context '#to_a' do
      it 'can convert to array' do
        cell = Cell.new 0, 0, :board
        expect(cell.to_a == [0, 0]).to be(true)
      end
    end

    context '#alive?' do
      it 'can tell if cell is dead or alive' do
        # alive
        board = Board.new [0, 0]
        cell = Cell.new 0, 0, board
        expect(cell.alive?).to be(true)
        # dead
        board = Board.new
        cell = Cell.new 0, 0, board
        expect(cell.alive?).to be(false)
      end
    end

    context '#neighbours' do
      it 'can give cell\'s neighbours' do
        cell = Cell.new 0, 0, :board
        # expected_result = [
        #   [-1, -1], [-1, 0], [-1, 1],
        #   [ 0, -1],          [ 0, 1],
        #   [ 1, -1], [ 1, 0], [ 1, 1]
        # ]
        expected_result = [-1, 0, 1]
                          .repeated_permutation(2)
                          .reject { |element| element == [0, 0] }
                          .collect { |coord| Cell.new(*coord, :board) }
        expect(cell.neighbours == expected_result).to be(true)
      end
    end

    context '#living_neoghbours' do
      it 'can tell which neighbours are alive' do
        board = Board.new [0, 0], [-1, -1], [-1, 0]
        cell = Cell.new 0, 0, board
        lvn1 = Cell.new(-1, -1, board)
        lvn2 = Cell.new(-1, 0, board)
        expected_result = [lvn1, lvn2]
        expect(cell.living_neighbours == expected_result).to be(true)
      end
    end

    context '#should_live?' do
      it 'should die if underpopulated' do
        board = Board.new [0, 0]
        cell = Cell.new 0, 0, board
        expect(cell.should_live?).to be(false)
      end
      it 'should continue living if 2-3 living neighbours' do
        board = Board.new [0, 0], [-1, -1], [-1, 0]
        cell = Cell.new 0, 0, board
        expect(cell.should_live?).to be(true)
        board.add_cells Cell.new(0, -1, board)
        expect(cell.should_live?).to be(true)
      end
      it 'should die if overpopulated' do
        board = Board.new [0, 0], [-1, -1], [-1, 0], [-1, 1], [0, -1]
        cell = Cell.new 0, 0, board
        expect(cell.should_live?).to be(false)
      end
      it 'should repriduce if has 3 living neighbours' do
        board = Board.new [-1, -1], [-1, 0], [-1, 1]
        cell = Cell.new 0, 0, board
        expect(cell.should_live?).to be(true)
      end
    end
  end
end
