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

    new_board = Marshal.load(Marshal.dump(@board))

    @board.each.with_index do |row, i|
      row.each.with_index do |col, j|

        living_siblings = number_living_siblings(i, j)

        if col == 'X' && (living_siblings < 2 || living_siblings > 3)
          new_board[i][j] = '.'
        end

        if col == '.' && living_siblings == 3
          new_board[i][j] = 'X'
        end

      end
    end

    @board = new_board
  end

  def number_living_siblings(row, col)

    living_siblings = 0
    range = -1..1

    range.each do |i|
      range.each do |j|

        sibling = { :row => row + i, :col => col + j }
        is_self = (sibling[:row] == row) && (sibling[:col] == col)
        is_row_valid = sibling[:row] >= 0 && sibling[:row] < @board.length
        is_col_valid = sibling[:col] >= 0 && sibling[:col] < @board[row].length
        is_valid_coordinate = is_row_valid && is_col_valid

        if !is_self && is_valid_coordinate && @board[sibling[:row]][sibling[:col]] == 'X'
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

  def test_number_of_living_neighbors
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
