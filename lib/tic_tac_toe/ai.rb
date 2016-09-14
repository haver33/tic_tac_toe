module AI
  class Engine
    def initialize(board)
      @board = board
    end

    # Defense is always the first priority.
    # If there is a threatened line (the other player having only one move left to win), 
    # then this move must be used to defend against it.
    # Otherwise, this move will be played offensively.
    # Either way, we will return the space where we have decided to make our move.
    #
    def select_space
      play_defense or play_offense
    end

    # Get the line in which the other player has just one space left to win and claim the empty space.
    # Return true to show that this player's move has been made and his turn is over.
    # If there is no threatened line then do not return anything (an offensive move will be made).
    #
    def play_defense
      line = threatened_line
      if line
        line.spaces.each { |space| return space unless space.value }
      end
    end

    # Sort all available lines to see which has the most marks belonging to the other player.
    # If there is a line in which the other player has just one space left to win, return that line.
    # Otherwise, there is no immediate threat, so return nothing.
    #
    def threatened_line
      mark = @board.other_player.mark
      sorted_lines = sort_by_mark(mark)
      most_threatened_line = sorted_lines[0]
      most_threatened_line if most_threatened_line.marks(mark) == @board.size - 1
    end

    # Get the line with the most marks belonging to the current player and claim a random open space.
    #
    def play_offense
      empty_spaces = best_line.spaces.select { |space| space.value.nil? } 
      empty_spaces.sample
    end

    # Sort all available lines to see which has the most marks belonging to the current player.
    # Return the first (i.e. highest) result.
    #    
    def best_line
      mark = @board.current_player.mark
      sorted_lines = sort_by_mark(mark)
      sorted_lines[0]
    end

    # We naively sort to prefer lines that have the largest amount of our marks.
    # This can be improved.
    #
    def sort_by_mark(mark)
      @board.available_lines.sort do |line_a, line_b| 
        line_b.marks(mark) <=> line_a.marks(mark)
      end
    end
  end
end
