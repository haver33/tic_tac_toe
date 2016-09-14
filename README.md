##play
To play this game navigate to the /bin directory and run `ruby tic_tac_toe`

## test
To run the tests just run `rspec .`

## win detection
Here is an outline of how the win detection works (the code itself is extensively documented):

Parsing the board on every turn into rows, columns and diagonals, then checking them for X and O marks is inefficient.

Instead, we will parse the board only once, on startup. The way this works is by using an array of Space objects representing each space on the board.
We start by storing these unique Space objects in a simple array. Then we proceed to parse the board into every possible line (i.e. row, column, diagonal), each
one of which will now contain the unique Space objects corresponding to its spaces. Since we're using objects, any change made to the value of one of the Spaces
(such as setting the value to :X or :O) will be available to every line holding that same object.

Therefore, when setting the value of a Space, we only need to set the value of the Space object in our simple array. 
On each turn we will examine the existing array of lines to be informed if either player has marked every space on the line, signalling a win.