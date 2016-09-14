require_relative 'init_spec'

describe TicTacToe::Line do
  before :each do 
    spaces = Array.new(size*size) { Space.new }
    @line = Line.new(spaces)
  end
end

describe TicTacToe::Board do
  before :each do 
    TicTacToe.ui = UI::Terminal.new
    @board = TicTacToe::Board.new(3)
  end

  describe '#available_lines?' do
    it 'should tell us that there are 3 available lines' do
      @board.grid[0][0].value = :O 
      @board.grid[0][1].value = :X 
      @board.grid[0][2].value = :O 
      @board.grid[1][0].value = :O 
      @board.grid[1][1].value = :X 
      @board.grid[1][2].value = :X 
      @board.grid[2][0].value = :X 
      @board.grid[2][1].value = :O 

      expect(@board.available_lines.length).to equal(3)
    end
  end 
  
  describe '#game_over?' do
    it 'should tell us the game is over if one player won' do
      @board.available_lines[0].spaces[0].value = :X 
      @board.available_lines[0].spaces[1].value = :X 
      @board.available_lines[0].spaces[2].value = :X

      expect(@board.game_over?).to equal(true)
    end

    it 'should tell us the game when there is a draw' do
      @board.grid[0][0].value = :O 
      @board.grid[0][1].value = :X 
      @board.grid[0][2].value = :O 
      @board.grid[1][0].value = :O 
      @board.grid[1][1].value = :X 
      @board.grid[1][2].value = :X 
      @board.grid[2][0].value = :X 
      @board.grid[2][1].value = :O 
      @board.grid[2][2].value = :O 

      expect(@board.game_over?).to equal(true)
    end
  end 

  describe '#draw?' do 
    it "should tell us the the game is not a draw when it's not'" do
      expect(@board.draw?).to equal(false)
    end
    
    it "should tell us the the game is a draw when it is" do
      @board.grid[0][0].value = :O 
      @board.grid[0][1].value = :X 
      @board.grid[0][2].value = :O 
      @board.grid[1][0].value = :O 
      @board.grid[1][1].value = :X 
      @board.grid[1][2].value = :X 
      @board.grid[2][0].value = :X 
      @board.grid[2][1].value = :O 
      @board.grid[2][2].value = :O 
      expect(@board.draw?).to equal(true)
    end
  end
  
  describe '#rows' do 
    it "should return the number of rows" do
      expect(@board.send(:rows).length).to equal(3)
    end
  end
  
  describe '#columns' do 
    it "should return the number of columns" do
      expect(@board.send(:columns).length).to equal(3)
    end
  end
  
  describe '#diagonals' do 
    it "should return the number of diagonals" do
      expect(@board.send(:diagonals).length).to equal(2)
    end
  end

  describe '#game_over?' do 
    it "should return true if the game is over" do
      @board.grid[0][0].value = :X
      @board.grid[1][1].value = :X
      @board.grid[2][2].value = :X
      expect(@board.game_over?).to equal(true)
    end
  end
  
  describe '#initialize' do 
    it "should return an instance of TicTacToe::Board" do
      expect(@board).to be_an_instance_of TicTacToe::Board
    end
    
    it "should hold all the spaces on the board" do
      expect(@board.instance_variable_get(:@spaces).length).to equal(9)
    end
    
    it "should hold all the lines on the board" do
      expect(@board.instance_variable_get(:@lines).length).to equal(8)
    end
  end
end