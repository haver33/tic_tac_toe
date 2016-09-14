module UI
  class Terminal
    attr_writer :board

    # Allow the user to pick any size for the board.
    #
    def board_size
      size = nil

      until size
        clear_screen "Please enter the board size you wish to play on. \nAny number is valid (though less than 3 is kinda dumb, trust me)"
        size = gets.chomp.to_i
      end

      size
    end

    def display_welcome
      clear_screen("Welcome to TicTacToe!", 2)
    end

    # Allow the user to select who goes first. Repeat the question until they enter a valid response.
    # Then ask them to pick their mark (X or O). Repeat the question until they enter a valid response.
    # Create both players and yield them to the block.
    #
    def players
      human_turn, human_mark = nil, nil

      until human_turn == 'first' || human_turn == 'second'
        clear_screen "Well, well human... Do you wish to play first or second? (options: first, second)"
        human_turn = gets.chomp
      end
      
      until human_mark == 'X' || human_mark == 'O'
        clear_screen "And do you wish to be X or O? (options: X, O)"
        human_mark = gets.chomp
      end

      computer_mark = human_mark == 'X' ? 'O' : 'X'

      human_player = {type: :human, mark: human_mark.to_sym}
      computer_player = {type: :computer, mark: computer_mark.to_sym}

      players = [human_player, computer_player]
      players.reverse! if human_turn == 'second'

      players.collect { |player| yield(player) if block_given? }
    end

    # Ask the user to select an empty space.
    # We grab the index+1 of all available spaces and repeat our question until the user enters a valid number.
    #
    def select_space
      move = nil
      available_spaces = @board.spaces.collect.with_index { |space, i|  i+1 if space.value.nil? }
      available_spaces.select! { |v| v != nil }

      until available_spaces.include?(move)
        clear_screen display_board
        puts "\n\nYour turn! Please select a number from the board."
        move = gets.chomp.to_i
      end

      @board.spaces[move-1]
    end

    # The message will change depening on if there's a winner or it's a draw
    #
    def display_game_over
      clear_screen display_board
      puts "\nGAME OVER!!!!!!"

      message = @board.draw? ? "IT'S A DRAW!!!!" : "PLAYER #{@board.current_player.mark} WINS!!!!!"
      puts "\n#{message}"
    end

    def play_again?
      answer = nil

      until answer == 'y' || answer == 'n'
        puts "\nWant to play again? (options: y, n)"
        answer = gets.chomp
      end

      true if answer == 'y'
    end

    def clear_screen(output=nil, delay=nil)
      puts "\e[H\e[2J"
      puts output if output
      sleep(delay) if delay
    end

    # Dynamically generating a board of any size is tricky. Especially since we want to show the numbers inside the empty spaces, 
    # which throws off the alignment of the board. The solution is to calculate the length of the highest showable number and
    # to then pad all the spaces equal to that width. 
    
    # Iterate over every row, building an array of strings representing rows and join them all to output the board..
    #
    def display_board
      board = @board.grid.inject([]) do |board_rows, row|  
        board_rows + board_row(row)
      end

      board.pop 
      board.join("\n")
    end

    private

    # For each row, iterate over all the spaces, generating a string representing each space with its value.
    # If the space is empty then set the value of that space to the index+1 of that space.
    # The user will be able to select an empty square by selecting the number inside the square.
    # Calculate the width of the largest value we will show and then pad all values accordingly so that the board is aligned correctly.
    # Once all the rows are complete, remove the last horizontal line so the board looks right.
    #
    def board_row(row)
      board_row = Array.new(4, '')
        
      row.each_with_index do |space, index|
        space_index = @board.spaces.index(space) + 1
        vertical_line = '|' unless index == row.length-1

        padding = adjusted_padding

        extension = horizontal_line_extension(padding)

        val = space.value || space_index
        val = val.to_s
        val = val_with_padding(val, padding)
        val = val_with_color(val, space)
        
        padding = padding.join('')

        board_row[0] += "   %s     %s" % [padding, vertical_line]
        board_row[1] += "   %s     %s" % [val, vertical_line]
        board_row[2] += "   %s     %s" % [padding, vertical_line]
        board_row[3] += "---%s------" % [extension]
      end

      board_row
    end

    def adjusted_padding
      number_of_board_spaces = @board.spaces.length
      max_val_str_width = number_of_board_spaces.to_s.length
      (0...max_val_str_width).collect { ' ' }
    end

    def horizontal_line_extension(padding)
      p = padding.collect { '-' }
      p.join('')
    end

    def val_with_padding(val, padding)
      p = padding.clone
      val.split('').each_with_index { |v, i| p[i] = v }
      p.join('')
    end

    def val_with_color(val, space)
      case space.value
        when :X
          green(val)
        when :O
          red(val)
        else
          yellow(val)
        end
    end

    def colorize(color_code, message)
      "\e[#{color_code}m#{message}\e[0m"
    end

    def green(message)
      colorize(32, message)
    end

    def red(message)
      colorize(31, message)
    end

    def yellow(message)
      colorize(33, message)
    end
  end
end