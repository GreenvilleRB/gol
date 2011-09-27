class Runner
  
  attr_reader :board

  # Represent living cells with 'X', dead ones with a .
  def initialize(array)
    @board = array
  end

  def next_step

  end

end

require 'minitest/spec'
require 'minitest/autorun'

describe Runner do
  before do
    @start = [%w{X . X},
              %w{. X .},
              %w{X . X}]
  
    @end = [%w{. X .},
            %w{X . X},
            %w{. X .}]

    @game = Runner.new @start
  end

  it "takes the next step" do
    @game.next_step

    @game.board.must_equal @end
  end
end
