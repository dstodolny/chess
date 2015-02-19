module Chess
  class Piece
    include ChessHelper

    attr_accessor :location, :moves, :passable, :passable_turn
    attr_reader :color, :icon

    def initialize(input = {})
      @color = input.fetch(:color, :white)
      @location = input.fetch(:location, "A1")
      @moves = 0
      @passable = false
      @icon = color == :white ? "\u2659" : "\u265F"
    end

    def valid_move?(chessboard, to)
      if to == location
        return false
      elsif friend?(chessboard.get_square(to))
        return false
      elsif chessboard.path_blocked?(location, to)
        return false
      else
        return true
      end
    end

    def move_to(_, to)
      @location = to
      @moves += 1
    end

    def friend?(piece)
      piece.color == color if piece.is_a?(Piece)
    end

    def enemy?(piece)
      piece.color != color if piece.is_a?(Piece)
    end

    def to_be_promoted?
      return false unless self.instance_of?(Pawn)
      (color == :white && location[1] == "8") || (color == :black && location[1] == "1")
    end

    def to_s
      icon
    end
  end

  class Pawn < Piece
    def initialize(input = {})
      super
      @icon = color == :white ? "\u2659" : "\u265F"
    end

    def valid_move?(chessboard, to)
      x_from, y_from = get_xy(location)
      x_to, y_to = get_xy(to)
      destination = chessboard.get_square(to)
      side = color == :white ? 1 : -1

      dx = distance(x_from, x_to)
      dy = distance(y_from, y_to)

      if dx == 0 && dy == 1 && (side * (y_to - y_from)) > 0 && destination == " "
      elsif dx == 0 && dy == 2 && (y_from == 1 || y_from == 6) && destination == " "
      elsif dx == 1 && dy == 1 && enemy?(destination)
      elsif dx == 1 && dy == 1 && destination == " " && en_passant?(chessboard, to)
      else
        return false
      end
      super
    end

    def move_to(chessboard, to)
      _, y_from = get_xy(location)
      _, y_to = get_xy(to)
      @passable = (y_from - y_to).abs == 2 ? true : false
      @passable_turn = chessboard.moves if @passable
      super
    end

    def en_passant?(chessboard, to)
      x_to, y_to = get_xy(to)
      side = color == :black ? 1 : -1

      piece = chessboard.board[y_to + side][x_to]
      return true if piece.instance_of?(Pawn) && piece.color != color && piece.passable == true && piece.passable_turn == chessboard.moves
      false
    end

    def attack_squares
      side = color == :white ? 1 : -1
      neighbours(location[0]).map { |letter| letter + (location[1].to_i + side).to_s }
    end
  end

  class Knight < Piece
    def initialize(input = {})
      @knight_moves = [[-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2]]
      super
      @icon = color == :white ? "\u2658" : "\u265E"
    end

    def valid_move?(chessboard, to)
      x_from, y_from = get_xy(location)
      x_to, y_to = get_xy(to)

      dx = x_from - x_to
      dy = y_from - y_to

      if @knight_moves.include?([dx, dy])
      else
        return false
      end
      super
    end
  end

  class Bishop < Piece
    def initialize(input = {})
      super
      @icon = color == :white ? "\u2657" : "\u265D"
    end

    def valid_move?(chessboard, to)
      x_from, y_from = get_xy(location)
      x_to, y_to = get_xy(to)

      dx = (x_from - x_to).abs
      dy = (y_from - y_to).abs

      bishop_moves = chessboard.get_squares(location, to)
      if !bishop_moves.empty? && chessboard.going_diagonally?(dx, dy)
      else
        return false
      end
      super
    end
  end

  class Rook < Piece
    def initialize(input = {})
      super
      @icon = color == :white ? "\u2656" : "\u265C"
    end

    def valid_move?(chessboard, to)
      x_from, y_from = get_xy(location)
      x_to, y_to = get_xy(to)

      dx = (x_from - x_to).abs
      dy = (y_from - y_to).abs

      rook_moves = chessboard.get_squares(location, to)
      if !rook_moves.empty? && !chessboard.going_diagonally?(dx, dy)
      else
        return false
      end
      super
    end
  end

  class Queen < Piece
    def initialize(input = {})
      super
      @icon = color == :white ? "\u2655" : "\u265B"
    end

    def valid_move?(chessboard, to)
      queen_moves = chessboard.get_squares(location, to)
      if !queen_moves.empty?
      else
        return false
      end
      super
    end
  end

  class King < Piece
    def initialize(input = {})
      @king_moves = [[-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0]]
      super
      @icon = color == :white ? "\u2654" : "\u265A"
    end

    def valid_move?(chessboard, to)
      x_from, y_from = get_xy(location)
      x_to, y_to = get_xy(to)

      dx = distance(x_from, x_to)
      dy = distance(y_from, y_to)

      if @king_moves.include?([dx, dy])
      else
        return false
      end
      super
    end

    def in_check?(chessboard, san = location)
      square = chessboard.get_square(san)

      enemies = chessboard.get_pieces(other_color(color))
      pawns = enemies.select { |piece| piece.instance_of?(Pawn) }

      result = enemies.any? { |enemy| enemy.valid_move?(chessboard, san) } ||
        pawns.any? { |pawn| pawn.attack_squares.include?(san) }
      result
    end

    def can_castle?(chessboard, to)
      rook = chessboard.get_square(to)

      squares = get_sans(location, get_castling_san(to))

      if moves != 0 || rook.moves != 0
        return false
      elsif squares.any? { |square| in_check?(chessboard, square) }
        return false
      else
        return true
      end
    end

    def valid_moves
      x, y = get_xy(location)

      @king_moves.map { |move| get_san([move[0] + x, move[1] + y]) }.compact
    end

    def in_checkmate?(chessboard)
      friends = chessboard.get_pieces(color)
      enemies = chessboard.get_pieces(other_color(color))
      return false unless in_check?(chessboard, location)

      friends_result = friends.any? do |friend|
        all_moves.any? do |move|
          if friend.valid_move?(chessboard, move)
            square = chessboard.get_square(move)
            loc = friend.location

            chessboard.set_square(move, friend)
            chessboard.clear_square(friend.location)
            friend.move_to(chessboard, move)

            check = in_check?(chessboard, location)

            chessboard.set_square(loc, friend)
            chessboard.set_square(move, square)
            friend.move_to(chessboard, loc)

            if check == false
              true
            end
          end
        end
      end
      
      # king_result = valid_moves.all? do |move|
      #   square = chessboard.get_square(move)
      #   loc = location

      #   chessboard.set_square(move, self)
      #   chessboard.clear_square(location)
      #   move_to(chessboard, move)

      #   check = in_check?(chessboard, move)
      #   chessboard.set_square(loc, self)
      #   chessboard.set_square(move, square)
      #   move_to(chessboard, loc)
      #   check
      # end

      !friends_result
      # valid_moves.select { |move| valid_move?(chessboard, move) }.all? { |move| in_check?(chessboard, move) } 
      # false
    end
  end
end