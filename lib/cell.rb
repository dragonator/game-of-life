module GameOfLife
  # Class to represent a single cell on the board of GameOfLife
  class Cell
    attr_accessor :x
    attr_accessor :y
    attr_accessor :board

    def initialize(x, y, board)
      @x = x
      @y = y
      @board = board
    end

    def ==(other)
      (other.x == @x) && (other.y == @y) && (other.board == @board)
    end

    def eql?(other)
      self == other
    end

    def hash
      "row:#{@x};col:#{@y};board:#{@board.object_id}".hash
    end

    def to_a
      [@x, @y]
    end

    def alive?
      @board[@x, @y]
    end

    def neighbours
      [-1, 0, 1].repeated_permutation(2)
                .reject { |element| element == [0, 0] }
                .collect { |sx, sy| Cell.new(@x + sx, @y + sy, @board) }
    end

    def living_neighbours
      neighbours.select(&:alive?)
    end

    def should_live?
      living_neighbours_count = living_neighbours.count
      if alive?
        # Any live cell with fewer than two live neighbours dies,
        # as if caused by underpopulation.
        return false if living_neighbours_count < 2
        # Any live cell with two or three live neighbours lives
        # on to the next generation.
        return true if living_neighbours_count.between?(2, 3)
        # Any live cell with more than three live neighbours dies,
        # as if by overpopulation.
        return false if living_neighbours_count > 3
      # Any dead cell with exactly three live neighbours becomes
      # a live cell, as if by reproduction.
      elsif living_neighbours_count.eql? 3
        return true
      end
    end
  end
end
