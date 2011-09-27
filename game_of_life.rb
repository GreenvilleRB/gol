class Runner
  
  attr_reader :board

  # Represent living cells with 'X', dead ones with a .
  def initialize(array)
    @board = array
  end

  def next_step

  end

end

require 'test/unit'

class RunnerTest < Test::Unit::TestCase
  def setup
    @start = [%w{X . X},
              %w{. X .},
              %w{X . X}]

    @end = [%w{. X .},
            %w{X . X},
            %w{. X .}]

    @game = Runner.new @start
  end

  def teardown
    @start = nil
    @end = nil
    @game = nil
  end

  def test_taking_the_next_step
    @game.next_step

    assert_equal(@end, @game.board)
  end
end
