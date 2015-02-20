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
        if current_player.king(chessboard).in_checkmate?(chessboard)
          chessboard.display
          puts "CHECKMATE!"
          puts "#{other_player.name} wins the game"
          break
        end

        puts ""
        puts "Turn #{chessboard.moves / 2}"
        chessboard.display
        print "#{current_player.name}, enter your move: "
        command = gets.chomp
        case command
        when "quit"
          puts "Bye!"
          break
        when "save"
          save_game
          puts "Game saved"
        when "load"
          if File.exists?("saved_game")
            load_game
            puts "Game loaded"
          else
            puts "No file to load"
          end
        else
          loop do
            moved = make_move(command)
            break if moved
            puts "Invalid move. Try again."
            print "#{current_player.name}, enter your move: "
            command = gets.chomp
          end
          switch_players
        end
      end
    end

    def switch_players
      @current_player, @other_player = @other_player, @current_player
    end

    def make_move(input)
      move = input.match(/([a-hA-H][1-8]).*([a-hA-H][1-8])/)
      return false if move.nil?
      from = move[1].upcase
      to = move[2].upcase
      square = chessboard.get_square(from)
      return false if  square == " " || square.color != @current_player.color

      # test if king will be in check
      destination = chessboard.get_square(to)

      chessboard.set_square(to, square)
      chessboard.clear_square(from)
      square.move_to(chessboard, to)
      square.moves -= 1
      check = @current_player.king(chessboard).in_check?(chessboard)
      chessboard.set_square(from, square)
      chessboard.set_square(to, destination)
      square.move_to(chessboard, from)
      square.moves -= 1

      return false if check
      chessboard.move(from, to)
    end

    def save_game
      store = PStore.new('saved_game')
      store.transaction do
        store[:chessboard] = @chessboard
        store[:white_player] = @white_player
        store[:black_player] = @black_player
        store[:current_player] = @current_player
        store[:other_player] = @other_player
      end
    end

    def load_game
      store = PStore.new('saved_game')
      store.transaction do
        @chessboard = store[:chessboard]
        @white_player = store[:white_player]
        @black_player = store[:black_player]
        @current_player = store[:current_player]
        @other_player = store[:other_player]
      end
    end
  end
end
