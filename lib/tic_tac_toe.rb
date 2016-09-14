require 'pp'
require_relative "tic_tac_toe/ui"
require_relative "tic_tac_toe/base"
require_relative "tic_tac_toe/board"
require_relative "tic_tac_toe/player"

module TicTacToe
  # The Game class controls the flow of the game from a high level.
  #
  class Game < Base
    # We do not want to tie ourselves to any particular UI. Therefore, the Terminal
    # object is completely indendent of the TicTacToe module. Since we have other classes
    # that need access to the UI object as well, and since we should only need to set it once,
    # we set it on the Base superclass as a class variable.
    #
    def self.in_terminal(board_size=nil)
      TicTacToe.ui = UI::Terminal.new
      Game.new(board_size)
    end

    def initialize(board_size=nil)
      super()
      size = board_size || @ui.board_size
      @board = Board.new(size)
      @ui.board = @board
    end

    # We get the players and proceed to loop until the game is over.
    #
    def play
      @ui.display_welcome

      @player_one, @player_two = @ui.players { |player| assign_player(player) }

      until @board.game_over? do
        make_move
      end

      @ui.display_game_over
    end

    def assign_player(player)
      player[:board] = @board

      if player[:type] == :human 
        HumanPlayer.new(player)
      else 
        player[:ai] = AI::Engine.new(@board)
        ComputerPlayer.new(player)
      end
    end

    def make_move
      player = next_player 
      player.make_move
    end

    # When this is first run it will set the current_player to player_one
    #
    def next_player
      if @board.current_player == @player_one
        @board.current_player, @board.other_player = @player_two, @player_one
      else
        @board.current_player, @board.other_player = @player_one, @player_two
      end
      
      @board.current_player    
    end
  end
end