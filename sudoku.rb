class Sudoku
  def initialize(board, options = {})
    @solutions = 0
    @get_all_solutions = options[:get_all_solutions]
    @print_solutions = options[:print_them]
    @board = board
  end

  def print_state
    puts "+-----------------------+"
    @board.each_with_index do |row, row_i|
      print "| "
      row.each_with_index do |cell, column_i|
        print cell, " "
        print "| " if [2, 5].include?(column_i)
      end
      print "|"
      print "\n"
      print "|-------+-------+-------|\n" if [2, 5].include?(row_i)
    end
    puts "+-----------------------+"
    puts ""
  end

  def solutions
    return unless @get_all_solutions

    puts "#{@solutions} solutions overall" 
  end

  def solve
    return true if !get_empty_cell
    row_i, column_i = get_empty_cell
    
    (1..9).each do |digit|
      if valid_digit?(digit, row_i, column_i)
        @board[row_i][column_i] = digit

        if solve
          return true unless @get_all_solutions
          @solutions += 1
          solutions if !@print_solutions && @solutions % 1000 == 0
          print_state if @print_solutions
        end
          
        @board[row_i][column_i] = 0
      end
    end
    false
  end
  
  private

  def valid_digit?(digit, row_i, column_i)
    return false if @board[row_i].include?(digit)
    return false if @board.transpose[column_i].include?(digit)
    return fits_square?(digit, row_i, column_i)
  end

  def get_empty_cell
    @board.each_with_index do |row, row_i|
      row.each_with_index do |cell, col_i|
        return [row_i, col_i] if cell == 0
      end
    end

    false
  end

  def fits_square?(digit, row_i, column_i)
    square = []
    x = column_i / 3 * 3
    y = row_i / 3 * 3

    3.times do 
      square += @board[y][x..x+2]
      y += 1
    end

    return false if square.include?(digit)

    true
  end
end

hard_board = [[0, 3, 4,    0, 7, 8,    9, 0, 2],
              [0, 7, 2,    1, 9, 0,    3, 4, 8],
              [0, 9, 8,    3, 4, 2,    0, 0, 7],

              [8, 0, 9,    7, 0, 1,    4, 2, 3],
              [4, 2, 0,    8, 0, 3,    7, 9, 1],
              [7, 1, 3,    9, 2, 4,    8, 0, 0],

              [9, 0, 1,    0, 3, 7,    2, 8, 4],
              [2, 8, 7,    4, 1, 9,    0, 3, 0],
              [0, 0, 0,    0, 0, 0,    0, 0, 0]]

easy_board = [[5, 3, 4,    6, 7, 8,    9, 1, 2], 
              [6, 7, 2,    1, 9, 5,    3, 4, 8], 
              [1, 9, 8,    3, 4, 2,    5, 6, 7], 

              [8, 5, 9,    7, 6, 1,    4, 2, 3], 
              [4, 2, 6,    8, 5, 3,    7, 9, 1], 
              [7, 1, 3,    9, 2, 4,    8, 5, 6], 

              [9, 6, 1,    5, 3, 7,    2, 8, 4], 
              [2, 8, 7,    4, 1, 9,    6, 3, 5], 
              [3, 4, 5,    2, 8, 6,    1, 7, 9]]

empty_board =[[0, 0, 0,    0, 0, 0,    0, 0, 0],
              [0, 0, 0,    0, 0, 0,    0, 0, 0],
              [0, 0, 0,    0, 0, 0,    0, 0, 0],

              [0, 0, 0,    0, 0, 0,    0, 0, 0],
              [0, 0, 0,    0, 0, 0,    0, 0, 0],
              [0, 0, 0,    0, 0, 0,    0, 0, 0],
              
              [0, 0, 0,    0, 0, 0,    0, 0, 0],
              [0, 0, 0,    0, 0, 0,    0, 0, 0],
              [0, 0, 0,    0, 0, 0,    0, 0, 0]]


t1 = Time.now.to_f              
  sudoku = Sudoku.new(empty_board, get_all_solutions: false, print_them: false)
  sudoku.print_state
  sudoku.solve
  sudoku.print_state
  sudoku.solutions
t2 = Time.now.to_f

puts "Took #{t2-t1} seconds"

# Pass `true` and `true` to the constructor to see all possible solutions
# Pass `false` and `false` to get only one
# Don't waste your time passing in an empty board to see how many possible solutions there are
# On my PC it would take approximately 89172131130.54065 years (in Crystal)
 
# But you can optimize the proccess by accounting for the fact that you can substitute 
# the numbers for each other in equivavent structures 
# (e. g. [ [1, 2, 3], [2, 3, 1], [3, 1, 2] ] square is equivalent to [ [3, 2, 1], [2, 1, 3], [1, 3, 2] ] )
# I didn't do the math, but that would reduce the calculation time in 9 (probably? maybe more)