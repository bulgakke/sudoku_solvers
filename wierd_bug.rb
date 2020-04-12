require_relative 'sudoku.rb'

empty1 = Array.new(9, [0, 0, 0, 0, 0, 0, 0, 0, 0])
empty2 = Array.new(9, Array.new(9, 0))
empty3 = [[0, 0, 0,    0, 0, 0,    0, 0, 0],
          [0, 0, 0,    0, 0, 0,    0, 0, 0],
          [0, 0, 0,    0, 0, 0,    0, 0, 0],

          [0, 0, 0,    0, 0, 0,    0, 0, 0],
          [0, 0, 0,    0, 0, 0,    0, 0, 0],
          [0, 0, 0,    0, 0, 0,    0, 0, 0],

          [0, 0, 0,    0, 0, 0,    0, 0, 0],
          [0, 0, 0,    0, 0, 0,    0, 0, 0],
          [0, 0, 0,    0, 0, 0,    0, 0, 0]
        ]

puts empty1 == empty2 && empty2 == empty3 && empty3 == empty1 # => true

game1 = Sudoku.new(empty1)
game2 = Sudoku.new(empty2)
game3 = Sudoku.new(empty3)


game1.solve

puts empty1 == empty2 && empty2 == empty3 && empty3 == empty1 # => false

game2.solve
game3.solve

game1.print_state
game2.print_state
game3.print_state

puts empty1 == empty2 && empty2 == empty3 && empty3 == empty1 # => false
