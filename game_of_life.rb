class Runner
  
  attr_reader :board

  # Represent living cells with 'X', dead ones with a .
  def initialize(array)
    @board = array
  end

  def next_step

  end

end

require 'rspec'

describe Runner do
  let!(:starting) { [%w{X . X}, %w{. X .}, %w{X . X}] }
  let!(:ending) { [%w{. X .}, %w{X . X}, %w{. X .}] }
  let!(:runner) { Runner.new(starting) }


  it "takes the next step" do
    runner.next_step

    runner.board.should == ending
  end
end

__END__
If you need to read up on Rspec mocks or stubs, head over to
https://www.relishapp.com/rspec/rspec-mocks
