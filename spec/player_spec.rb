require_relative 'init_spec'

describe TicTacToe::Player do
  before :each do 
    TicTacToe.ui = UI::Terminal.new
    @board = TicTacToe::Board.new(3)
    @player = TicTacToe::Player.new(ai: nil, mark: :X, type: :computer, board: @board)
  end

  describe '#initialize' do 
    it "should return an instance of TicTacToe::Player" do
    expect(@player).to be_an_instance_of TicTacToe::Player
    end
  end
end

describe TicTacToe::HumanPlayer do
  before :each do 
    TicTacToe.ui = UI::Terminal.new
    @board = TicTacToe::Board.new(3)
    @player = TicTacToe::HumanPlayer.new(ai: nil, mark: :X, type: :human, board: @board)
  end

  describe '#initialize' do 
    it "should return an instance of TicTacToe::HumanPlayer" do
    expect(@player).to be_an_instance_of TicTacToe::HumanPlayer
    end
  end
end

describe TicTacToe::ComputerPlayer do
  before :each do 
    TicTacToe.ui = UI::Terminal.new
    @board = TicTacToe::Board.new(3)
    @ai = AI::Engine.new(@board)
    @player = TicTacToe::ComputerPlayer.new(ai: @ai, mark: :X, type: :human, board: @board)
  end

  describe '#initialize' do 
    it "should return an instance of TicTacToe::ComputerPlayer" do
    expect(@player).to be_an_instance_of TicTacToe::ComputerPlayer
    end
  end
end