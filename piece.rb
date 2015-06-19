require_relative 'chess_modules'
class Piece
  attr_reader :color
  def initialize(color)
    @color = color
  end

end


class King < Piece
  include Horizontal
  include Vertical
  include Diagonal

  def moves(num)
    up = num + 10
    down =num - 10
    right = num + 1
    left = num - 1
    down_right = num - 9
    down_left = num - 11
    up_right = num + 11
    up_left = num + 9
    [[up],[down],[right],[left],[down_right],[down_left],[up_right],[up_left]].delete_if {|number| number[0] > 88 || number[0] < 11 || number[0] % 10 > 8 || number[0] % 10 < 1}
  end

  def to_s
    @color == :w ? '♔' : '♚'
  end

end


class Queen < Piece
  include Horizontal
  include Vertical
  include Diagonal

  def moves(num)
    self_moves = vertical(num).concat(horizontal(num).concat(diagonal(num))).delete_if {|no_moves| no_moves == []}
  end

  def to_s
    @color == :w ? '♕' : '♛'
  end

end


class Bishop < Piece
  include Diagonal

  def moves(num)
    self_moves = diagonal(num).concat([]).delete_if {|no_moves| no_moves == []}
  end

  def to_s
    @color == :w ? '♗' : '♝'
  end

end

class Rook < Piece
  include Vertical
  include Horizontal

  def moves(num)
    self_moves = vertical(num).concat(horizontal(num)).delete_if {|no_moves| no_moves == []}
  end

  def to_s
    @color == :w ? '♖' : '♜'
  end

end

class Knight < Piece

  def moves(num)
    pos_1 = num + 21
    pos_2 = num + 19
    pos_3 = num + 12
    pos_4 = num + 8
    pos_5 = num - 21
    pos_6 = num - 19
    pos_7 = num - 12
    pos_8 = num - 8
    [[pos_1],[pos_2],[pos_3],[pos_4],[pos_5],[pos_6],[pos_7],[pos_8]].delete_if {|number| number[0] % 10 > 8 || number[0] % 10 < 1 || number[0] < 11 || number[0] > 88}
  end

  def to_s
    @color == :w ? '♘' : '♞'
  end

end

class Pawn < Piece
  include Vertical
  include Diagonal

  def moves(num)
    if @color == :w
      up = (num + 10)
      up_right = (num + 11)
      up_left = (num + 9)
    else
      up = (num - 10)
      up_right = (num - 11)
      up_left = (num - 9)
    end
    [[up],[up_right],[up_left]].delete_if {|number|  number[0] > 88 || number[0] < 11 || number[0] % 10 < 1 || number[0] % 10 > 8}
  end


  def to_s
    @color == :w ? '♙' : '♟'
  end

end
