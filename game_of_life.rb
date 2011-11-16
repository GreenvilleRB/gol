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

  def number_living_siblings(row, col)

    living_siblings = 0
    range = -1..1

    range.each do |i|
      range.each do |j|

        neighbor = { :row => row + i, :col => col + j }
        is_self = (neighbor[:row] == row) && (neighbor[:col] == col)
        is_row_valid = neighbor[:row] >= 0 && neighbor[:row] < @board.length
        is_col_valid = neighbor[:col] >= 0 && neighbor[:col] < @board[row].length
        is_valid_coordinate = is_row_valid && is_col_valid

        if !is_self && is_valid_coordinate && @board[neighbor[:row]][neighbor[:col]] == 'X'
          living_siblings += 1
        end
      end
    end

    return living_siblings
  end

end

require 'test/unit'

class RunnerTest < Test::Unit::TestCase
  def test_number_of_living_neighbors
    board = [%w{X . X},
             %w{X . .},
             %w{X X X}]

    game = Runner.new board

    assert_equal 1, game.number_living_siblings(0, 0)
    assert_equal 3, game.number_living_siblings(0, 1)
    assert_equal 0, game.number_living_siblings(0, 2)
    assert_equal 3, game.number_living_siblings(1, 0)
    assert_equal 6, game.number_living_siblings(1, 1)
    assert_equal 3, game.number_living_siblings(1, 2)
    assert_equal 2, game.number_living_siblings(2, 0)
    assert_equal 3, game.number_living_siblings(2, 1)
    assert_equal 1, game.number_living_siblings(2, 2)
  end
end
