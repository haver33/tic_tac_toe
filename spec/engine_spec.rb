require_relative 'init_spec'

describe AI::Engine do
  before :each do 
    TicTacToe.ui = UI::Terminal.new
    @board = TicTacToe::Board.new(3)
    @ai = AI::Engine.new(@board)
  end

  describe '#select_space' do 
    it 'should return an offensive move if there is no immediate threat' do
      @board.current_player = TicTacToe::HumanPlayer.new(ai: nil, mark: :X, type: :computer, board: @board)
      @board.other_player = TicTacToe::HumanPlayer.new(ai: nil, mark: :O, type: :human, board: @board)
      
      # Set the 0,0 and 0,1 position of the board to :O
      @board.grid[0][0].value = :O 

      # We can only test that the space does not have a value. We can't tell more than that.
      expect(@ai.select_space.value).to equal(nil)
    end
    
    it 'should return a defensive move if there is an immediate threat' do
      @board.current_player = TicTacToe::HumanPlayer.new(ai: nil, mark: :X, type: :computer, board: @board)
      @board.other_player = TicTacToe::HumanPlayer.new(ai: nil, mark: :O, type: :human, board: @board)
      
      # Set the 0,0 and 0,1 position of the board to :O
      @board.grid[0][0].value = :O 
      @board.grid[0][1].value = :O

      # We can only test that the space does not have a value. We can't tell more than that.      
      expect(@ai.select_space.value).to equal(nil)
    end
  end
  
  describe '#play_defense' do 
    it 'should return the critical space if there is an immediate threat' do
      @board.other_player = TicTacToe::HumanPlayer.new(ai: nil, mark: :O, type: :human, board: @board)
      
      # Set the 0,0 and 0,1 position of the board to :O
      @board.grid[0][0].value = :O 
      @board.grid[0][1].value = :O

      expect(@ai.play_defense.value).to equal(nil)
    end
    
    it 'should return nothing if there is no immediate threat' do
      @board.other_player = TicTacToe::HumanPlayer.new(ai: nil, mark: :O, type: :human, board: @board)
      
      # Set the 0,0 and 0,1 position of the board to :O
      @board.grid[0][0].value = :O 

      expect(@ai.play_defense).to equal(nil)
    end
  end
  
  describe '#threatened_line' do 
    it 'should return the line which contains the greatest threat' do
      @board.other_player = TicTacToe::HumanPlayer.new(ai: nil, mark: :O, type: :human, board: @board)
      
      # Set the 0,0 and 0,1 position of the board to :O
      @board.grid[0][0].value = :O 
      @board.grid[0][1].value = :O

      expect(@ai.threatened_line.marks(:O)).to equal(2)
    end
  end
  
  describe '#play_offense' do 
    it 'should return a random space from the best line for the current player' do
      @board.current_player = TicTacToe::HumanPlayer.new(ai: nil, mark: :X, type: :computer, board: @board)
      
      # Set the 0,0 position of the board to :X
      @board.grid[0][0].value = :X 
      expect(@ai.play_offense).to be_an_instance_of TicTacToe::Space
      expect(@ai.play_offense.value).to eq(nil)
    end
  end
  
  describe '#best_line' do 
    it 'should return the best line for the current player' do
      @board.current_player = TicTacToe::HumanPlayer.new(ai: nil, mark: :X, type: :computer, board: @board)
      
      # Set the 0,0 position of the board to :X
      @board.grid[0][0].value = :X 
      expect(@ai.best_line.marks(:X)).to equal(1)
    end
  end

  describe '#sort_by_mark' do 
    it "should sort available lines by the given mark" do
        expect(@ai.sort_by_mark(:X).length).to equal(8)
    end
    
    it "should return a line containing the player's mark as the first result" do
        # Set the 0,0 position of the board to :X
        @board.grid[0][0].value = :X 
        expect(@ai.sort_by_mark(:X)[0].marks(:X)).to equal(1)
    end
    
    it "should return the line containing the largest number of the player's mark as the first result" do
        # Set the 0,0 and 0,1 position of the board to :X
        @board.grid[0][0].value = :X
        @board.grid[0][1].value = :X

        # Set the 1,0 position of the board to :X
        @board.grid[1][0].value = :X

        expect(@ai.sort_by_mark(:X)[0].marks(:X)).to equal(2)
    end
  end
  
  describe '#initialize' do 
    it "should return an instance of AI::Engine" do
      expect(@ai).to be_an_instance_of AI::Engine
    end
  end
end