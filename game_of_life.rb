class Runner

  # LIVING = 'X'
  # DEAD   = '.'
  #
  # Rules:
  # 1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
  # 2. Any live cell with two or three live neighbours lives on to the next generation.
  # 3. Any live cell with more than three live neighbours dies, as if by overcrowding.
  # 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

  attr_reader :board

  def initialize(array)
    @board = array
  end

  def step

    # Deep copy that nested array
    # http://stackoverflow.com/questions/1465696/ruby-how-can-i-copy-this-array#answer-1465787
    # We do this to freeze the state of the board, since living cell that dies
    # early in this iteration should still be considered alive when calculating
    # the living siblings of a cell later in the iteration.
    new_board = Marshal.load(Marshal.dump(@board))

    @board.each.with_index do |row, i|
      row.each.with_index do |col, j|

        living_siblings = number_living_siblings(i, j)

        # If the cell is living, but has less than 2 or more than 3 siblings,
        # it dies
        if col == 'X' && (living_siblings < 2 || living_siblings > 3)
          new_board[i][j] = '.'
        end

        # If the cell is dead, but has exactly 3 siblings, it comes alive
        if col == '.' && living_siblings == 3
          new_board[i][j] = 'X'
        end

        # Implicit: if a cell is living and has 2-3 living siblings, it remains
        # alive.
      end
    end

    # Replace with the new board
    @board = new_board
  end

  # Calculate the number of living siblings a given cell has
  def number_living_siblings(row, col)

    living_siblings = 0

    # Iterate in a circle around the given coordinate
    range = -1..1
    range.each do |i|
      range.each do |j|

        # Calculate the siblings coordinate
        sibling = { :row => row + i, :col => col + j }
        # And perform lots of validations to make sure
        # 1. It is not the cell in question
        is_self = (sibling[:row] == row) && (sibling[:col] == col)
        # 2. It is actually within the bounds of the board array
        is_row_valid = sibling[:row] >= 0 && sibling[:row] < @board.length
        is_col_valid = sibling[:col] >= 0 && sibling[:col] < @board[row].length

        is_valid_coordinate = !is_self && is_row_valid && is_col_valid

        # If the coordinate is valid and is living, add it to the count
        if is_valid_coordinate && @board[sibling[:row]][sibling[:col]] == 'X'
          living_siblings += 1
        end
      end
    end

    return living_siblings
  end

end

require 'test/unit'

class RunnerTest < Test::Unit::TestCase

  def setup
    @start = [%w{X . X},
              %w{X . .},
              %w{X X X}]

    @end   = [%w{. X .},
              %w{X . X},
              %w{X X .}]

    @game = Runner.new @start
  end

  def test_number_of_living_siblings
    assert_equal 1, @game.number_living_siblings(0, 0)
    assert_equal 3, @game.number_living_siblings(0, 1)
    assert_equal 0, @game.number_living_siblings(0, 2)
    assert_equal 3, @game.number_living_siblings(1, 0)
    assert_equal 6, @game.number_living_siblings(1, 1)
    assert_equal 3, @game.number_living_siblings(1, 2)
    assert_equal 2, @game.number_living_siblings(2, 0)
    assert_equal 3, @game.number_living_siblings(2, 1)
    assert_equal 1, @game.number_living_siblings(2, 2)
  end

  def test_step
    @game.step
    assert_equal @end, @game.board
  end
end
