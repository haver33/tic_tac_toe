require_relative "ai"

module TicTacToe
  class Player < Base
    attr_reader :mark, :type

    def initialize(ai: nil, mark: nil, type: nil, board: nil)
      super()
      @ai = ai
      @mark = mark
      @type = type
      @board = board
      @ui.board = @board
    end
  end

  class HumanPlayer < Player
    def make_move
      space = @ui.select_space
      space.value = @mark
      @ui.display_board
    end
  end

  class ComputerPlayer < Player
    def make_move
      space = @ai.select_space
      space.value = @mark
      @ui.display_board
    end
  end
end