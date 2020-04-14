require_relative 'sudoku.rb'

empty1 = Array.new(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]).freeze
empty2 = Array.new(9, Array.new(9, 0)).freeze
empty3 = [[0, 0, 0,    0, 0, 0,    0, 0, 0],
          [0, 0, 0,    0, 0, 0,    0, 0, 0],
          [0, 0, 0,    0, 0, 0,    0, 0, 0],

          [0, 0, 0,    0, 0, 0,    0, 0, 0],
          [0, 0, 0,    0, 0, 0,    0, 0, 0],
          [0, 0, 0,    0, 0, 0,    0, 0, 0],

          [0, 0, 0,    0, 0, 0,    0, 0, 0],
          [0, 0, 0,    0, 0, 0,    0, 0, 0],
          [0, 0, 0,    0, 0, 0,    0, 0, 0]
].freeze

dup1 = empty1.dup.freeze
dup2 = empty2.dup.freeze
dup3 = empty3.dup.freeze

puts "frozen = #{dup1.frozen?}" # => true
puts "frozen = #{dup2.frozen?}" # => true
puts "frozen = #{dup3.frozen?}" # => true

puts dup1 == dup2 && dup2 == dup3 && dup3 == dup1 # => true
puts empty1 == empty2 && empty2 == empty3 && empty3 == empty1 # => true

game1 = Sudoku.new(empty1)
game2 = Sudoku.new(empty2)
game3 = Sudoku.new(empty3)

game1.solve
game2.solve
game3.solve

game1.print_state # 123456789 in each row
game2.print_state # 123456789 in each row
game3.print_state # properly solved sudoku

puts dup1 == dup2 && dup2 == dup3 && dup3 == dup1 # => false
puts empty1 == empty2 && empty2 == empty3 && empty3 == empty1 # => false

puts "frozen = #{empty1.frozen?}" # => true
puts "frozen = #{empty2.frozen?}" # => true
puts "frozen = #{empty3.frozen?}" # => true

# If you check the process happening during Sudoku#solve, 
# you'll see each column filled with the same number in one step