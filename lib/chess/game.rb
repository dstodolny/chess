module Chess
  class Game
    attr_reader :chessboard, :current_player, :other_player

    def initialize
      @chessboard = Chessboard.new
      @white_player = Player.new(color: :white, name: "White")
      @black_player = Player.new(color: :black, name: "Black")
      @current_player = @white_player
      @other_player = @black_player
    end

    def play
      loop do
        p current_player.king(chessboard).in_checkmate?(chessboard)
        if current_player.king(chessboard).in_checkmate?(chessboard)
          puts "CHECKMATE!"
          puts "#{other_player.name} wins the game"
          break
        end

        puts "Turn #{chessboard.moves / 2}"
        chessboard.display
        loop do
          print "#{current_player.name}, enter your move: "
          moved = make_move(gets.chomp)
          break if moved
          puts "Invalid move. Try again."
        end
        puts "OK"
        switch_players
      end
    end

    def switch_players
      @current_player, @other_player = @other_player, @current_player
    end

    def make_move(input)
      move = input.match(/([a-hA-H][1-8]).*([a-hA-H][1-8])/)
      return false if move.nil?
      from = move[1]
      to = move[2]
      square = chessboard.get_square(from.upcase)
      return false if  square == " " || square.color != @current_player.color
      chessboard.move(from.upcase, to.upcase)
    end
  end
end
