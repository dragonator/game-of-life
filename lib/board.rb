require_relative 'cell'

module GameOfLife
  # Class to represent a board of GameOfLife
  class Board
    include Enumerable

    def initialize(*coordinates)
      @cells = coordinates.collect { |coord| Cell.new(*coord, self) }
    end

    def [](x, y)
      @cells.include? Cell.new x, y, self
    end

    def each(&block)
      @cells.each(&block)
    end

    def add_cells(*cells)
      @cells.push(*cells)
    end

    def population
      @cells.count
    end

    def next_generation
      Board.new(*@cells.collect { |cell| [cell, cell.neighbours] }
                       .flatten
                       .uniq
                       .select(&:should_live?)
                       .map(&:to_a))
    end
  end
end
