require 'stringio'
require_relative 'init_spec'

describe UI::Terminal do
  before :each do 
    TicTacToe.ui = UI::Terminal.new
    @board = TicTacToe::Board.new(5)
    @ui = UI::Terminal.new
    @ui.board = @board
  end

  # I ran out of time trying to figure out how to capture STDIN in order to 
  # test methods that call gets.chomp 

  describe '#display_game_over' do
    it 'should print to stdout that the game is over and which player won' do 
      @board.current_player = TicTacToe::Player.new(ai: nil, mark: :X, type: :computer, board: @board)
      @board.current_player.instance_eval('@mark = :X')
      expect{@ui.display_game_over}.to output.to_stdout 
    end
  end
  
  describe '#clear_screen' do
    it 'should print to stdout a clear screen command followed by our message' do 
      expect{@ui.clear_screen("TEST")}.to output("\e[H\e[2J\nTEST\n").to_stdout 
    end
  end
  
  describe '#adjusted_padding' do
    it 'should should return an array of spaces equal to the string size of the largest empty space number showable on the board' do 
      expect(@ui.send(:adjusted_padding)).to eq([" ", " "])
    end
  end
  
  describe '#horizontal_line_extension' do
    it 'should return a horizontal line of dashes equal in length to the given padding' do 
      expect(@ui.send(:horizontal_line_extension, [' ', ' '])).to eq("--")
    end
  end
  
  describe '#val_with_padding' do
    it 'should take the given padding array and insert the given value' do 
      expect(@ui.send(:val_with_padding, '15', [' ', ' '])).to eq("15")
    end
  end
  
  describe '#val_with_color' do
    it 'should colorize the mark with its corresponding color' do 
      space = TicTacToe::Space.new
      space.value = :X
      expect(@ui.send(:val_with_color, 'MESSAGE', space)).to eq("\e[32mMESSAGE\e[0m")
    end
  end

  describe '#display_board' do 
    it "should print the board to the screen" do
      # puts "\n", @ui.display_board
      # expect(@ui.display_board).to output("").to_stdout
    end
    
    it "should print the board to the screen including player marks" do
      @board.grid[0][0].value = :X
      @board.grid[1][1].value = :X
      @board.grid[2][2].value = :O
      # puts "\n", @ui.display_board
      # expect(@ui.display_board).to output("").to_stdout
    end
  end
end