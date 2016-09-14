require_relative 'init_spec'

describe TicTacToe::Game do
  before :each do 
    @game = TicTacToe::Game.in_terminal(3)
  end

  describe '#assign_player' do
    it 'should return a HumanPlayer when the given hash has a type :human' do
      player = {ai: nil, mark: :X, type: :human, board: nil}
      expect(@game.assign_player(player)).to be_an_instance_of TicTacToe::HumanPlayer
    end
    
    it 'should return a ComputerPlayer when the given hash has a type :human' do
      player = {ai: nil, mark: :X, type: :computer, board: nil}
      expect(@game.assign_player(player)).to be_an_instance_of TicTacToe::ComputerPlayer
    end
  end

  describe '#next_player' do 
    it "should set the current player to player_one and the other_player two player_two on startup" do
      @game.instance_eval('@player_one = TicTacToe::HumanPlayer.new(ai: nil, mark: :X, type: :computer, board: @board)')
      @game.instance_eval('@player_two = TicTacToe::ComputerPlayer.new(ai: nil, mark: :O, type: :computer, board: @board)')
      @game.next_player
      expect(@game.instance_variable_get(:@board).current_player.mark).to eq(:X)
    end

    it "should switch the current_player with the other_player" do
      @game.instance_eval('@player_one = TicTacToe::HumanPlayer.new(ai: nil, mark: :X, type: :computer, board: @board)')
      @game.instance_eval('@player_two = TicTacToe::ComputerPlayer.new(ai: nil, mark: :O, type: :computer, board: @board)')
      @game.instance_variable_get(:@board).current_player = @game.instance_variable_get(:@player_one)
      @game.instance_variable_get(:@board).other_player = @game.instance_variable_get(:@player_two)
      @game.next_player
      expect(@game.instance_variable_get(:@board).current_player.mark).to eq(:O)
    end
  end
  
  describe '#in_terminal' do 
    it "should return an instance of TicTacToe::Game" do
      expect(@game).to be_an_instance_of TicTacToe::Game
    end
    
    it "Game should have an instance UI::Terminal" do
      expect(TicTacToe.ui).to be_an_instance_of UI::Terminal
    end
  end
  
  describe '#initialize' do 
    it "should return an instance of TicTacToe::Game" do
      g = TicTacToe::Game.new(3)
      expect(g).to be_an_instance_of TicTacToe::Game
    end
  end
end