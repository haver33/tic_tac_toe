module TicTacToe
  # We do not want to tie ourselves to any particular UI. Therefore, the Terminal
  # object is completely indendent of the TicTacToe module. Since we have other classes
  # that need access to the UI object as well, and since we should only need to set it once,
  # we set it on the Base superclass as a class variable.
  #
  class << self
    attr_accessor :ui
  end

  class Base
    def initialize
      raise "A UI is required" unless TicTacToe.ui
      @ui = TicTacToe.ui
    end
  end    
end