class Runner
  
  attr_reader :board

  # Represent living cells with 'X', dead ones with a .
  def initialize(array)
    @board = array
  end

  def next_step

  end

end

require 'riot'
require 'riot/rr'

context "Runner" do
  setup do
    @start = [%w{X . X},
              %w{. X .},
              %w{X . X}]

    @end = [%w{. X .},
            %w{X . X},
            %w{. X .}]

    Runner.new(@start)
  end

  context "takes the next step" do
    hookup { topic.next_step }

    asserts(:board).equals @end
  end
end

__END__
If you need to use mocks or stubs, checkout out RR:
https://github.com/btakita/rr
