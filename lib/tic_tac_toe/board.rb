module TicTacToe

  # A Space represents a space on the board. 
  # A Space's value can be :X, :O or nil
  #
  class Space
    attr_accessor :value
  end

  # A line represents a line on the board, such as a row, column or diagonal.
  # On a standard 3x3 board there will be 8 lines: 3 rows, 3 columnns and 2 diagonals.
  #
  class Line
    attr_accessor :spaces

    def initialize(spaces)
      @spaces = spaces
    end 

    def available?
      @spaces.any? { |space| space.value.nil? }
    end

    def marks(mark)
      @spaces.count { |space| space.value == mark }
    end 

    # The game is won if a player's mark fills all the spaces of the line
    #
    def win?
      unique_spaces = @spaces.uniq { |space| space.value }
      unique_spaces.length == 1 && marks(nil) == 0
    end
  end

  # This is the key to how the AI keeps track of the game's status and decideds where to move.
  # Upon instantiation, we will create a simple array (@spaces) containing a Space object for every space on the board.
  # Then we will parse the board into every possible line (row, column, diagonal) and populate each line with
  # the corresponding Space from our @spaces array. This way we only have to parse the board into lines once, 
  # and any changes made to the value of a Space in the @spaces array will be available to every line that holds 
  # that Space (they are the same Space object).
  #
  class Board
    attr_accessor :size, :current_player, :other_player, :spaces, :grid

    def initialize(size)
      @size = size
      @spaces = Array.new(size*size) { Space.new }
      
      @grid = []
      @spaces.each_slice(size) { |slice| @grid << slice }
      
      @lines = []
      @lines += rows
      @lines += columns
      @lines += diagonals
    end

    def available_lines
      @lines.select { |line| line.available?  }
    end
    
    def game_over?
      @lines.any? { |line| line.win? } || available_lines.empty?
    end

    def draw?
      available_lines.empty? unless @lines.any? { |line| line.win? }
    end

    private

    def rows
      @grid.collect { |spaces| Line.new(spaces) }
    end
    
    def columns
      @grid.transpose.collect { |spaces| Line.new(spaces) }
    end
    
    def diagonals
      left_to_right = (0...@size).collect { |i| @grid[i][i] }
      right_to_left = (0...@size).collect { |i| @grid[i][-1-i] }
      [Line.new(left_to_right), Line.new(right_to_left)]
    end
  end
end  