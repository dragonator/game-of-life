require 'spec_helper'

module GameOfLife
  describe Board do
    it 'is Enumerable' do
      expect(Board.new).to be_a(Enumerable)
    end

    context '#[]' do
      it 'can tell if cell is dead or alive' do
        board = Board.new [0, -1], [0, 0], [0, 1]
        expect(board[0, -1]).to be(true)
        board = Board.new [0, -1], [0, 0], [0, 1]
        expect(board[1, 1]).to be(false)
      end
    end

    context '#each' do
      it 'can iterate through living cells' do
        board = Board.new [0, -1], [0, 0], [0, 1]
        cells_count = 0
        board.each { cells_count += 1 }
        expect(cells_count).to eq(3)
      end
    end

    context '#add_cells' do
      it 'can add living cell' do
        board = Board.new
        cell = Cell.new(0, 0, board)
        expect(board[0, 0]).to be(false)
        board.add_cells cell
        expect(board[0, 0]).to be(true)
      end
      it 'can add mulltiple cells at once' do
        board = Board.new
        cell1 = Cell.new(0, 0, board)
        cell2 = Cell.new(1, 0, board)
        expect(board[0, 0]).to be(false)
        expect(board[1, 0]).to be(false)
        board.add_cells cell1, cell2
        expect(board[0, 0]).to be(true)
        expect(board[1, 0]).to be(true)
      end
    end

    context '#population' do
      it 'can tell how much is it\'s population' do
        board = Board.new [0, -1], [0, 0], [0, 1]
        expect(board.population).to eq(3)
      end
    end

    context '#next_generation' do
      it 'can calculate the next generation' do
        board = Board.new [0, -1], [0, 0], [0, 1]
        next_gen = board.next_generation
        expect(next_gen[-1, 0]).to be(true)
        expect(next_gen[0, 0]).to be(true)
        expect(next_gen[1, 0]).to be(true)
        expect(next_gen.population).to eq(3)
      end
    end
  end
end
