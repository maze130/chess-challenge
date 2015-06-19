require_relative 'board'
require_relative 'view'
require 'pry'

class Chess
  DIMENSION = 8
  def initialize(board)
    @board = board
    # binding.pry
    run
  end

  def run
    game_turn = 1
    until @board.game_over?
      game_turn % 2 == 0 ? player = :b : player = :w
      View.display(@board.to_s)

      begin
        View.player_choose_piece(player)
        start_coord = trim_input(STDIN.gets)
        until valid_coord?(start_coord)
          View.valid_coord
          start_coord = trim_input(STDIN.gets)
          select_key = coord_key_convert(start_coord)
        end

        select_key = coord_key_convert(start_coord)
        View.select_own_pieces(player) if !@board.select_piece(select_key, player)
      end until @board.select_piece(select_key, player)

      valid_moves = @board.valid_moves(select_key).map { |key| key_coord_convert(key) }

      # makes player loose turn for selecting a piece with no valid moves
      # if valid_moves.empty?
      #   puts "Nice try, cheater!"
      #   game_turn += 1
      #   break
      # end
      break if valid_moves.empty?

      View.possible_moves(valid_moves)


      begin
        View.player_choose_move(player)
        end_coord = trim_input(STDIN.gets)
      end until valid_moves.include?(end_coord)

      @board.move(coord_key_convert(start_coord), coord_key_convert(end_coord))

      # View.display(@board.to_s)

      game_turn += 1
    end

  end

  #private
  def trim_input(input)
    input.chomp.downcase
  end

  def valid_coords
    rows = ('a'..'z').to_a[0...DIMENSION] * DIMENSION
    cols = ('1'..'26').to_a[0...DIMENSION].map { |col_num| col_num * DIMENSION }.map(&:chars).flatten
    rows.zip(cols).map(&:join)
  end

  def valid_coord?(coord)
    valid_coords.include?(coord)
  end

  def coord_key_convert(coord)
    # binding.pry
    row_keys = ('a'..'z').to_a[0...DIMENSION]
    row_values = (1..DIMENSION).to_a

    row_key_value_pairs = row_keys.zip(row_values)
    row_hash = row_key_value_pairs.each_with_object({}) { |pairs, hash| hash[pairs[0]] = pairs[-1] }
    # binding.pry
    row, col = coord.chars
    "#{row_hash[row]}#{col}".to_i
  end

  def key_coord_convert(key)

    row_keys = (1..DIMENSION).to_a
    row_values = ('a'..'z').to_a[0...DIMENSION]

    row_key_value_pairs = row_keys.zip(row_values)
    key_hash = row_key_value_pairs.each_with_object({}) { |pairs, hash| hash[pairs[0]] = pairs[-1] }

    # binding.pry
    row, col = key.to_s.chars
    "#{key_hash[row.to_i]}#{col}"
    # binding.pry
  end

end


Chess.new(Board.new)
