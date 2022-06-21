class Board
    def initialize(size=4)
        @PONE="X"
        @PTWO="O"
        @EMPTY=" "
        @board = Hash.new
        @size=size
        size.times{
            |x|
            size.times{
                |y|
                @board["#{x+1}x#{y+1}"] = @EMPTY
            }
        }
    end

    public

    def to_s
        board_string=' '
        @size.times{|i|
            board_string.concat("  #{i+1}")
        }
        board_string.concat "\n"
        @size.times{
            |x|
            board_string.concat("#{x+1} ")
            @size.times{
                |y|
                board_string.concat("|#{@board["#{x+1}x#{y+1}"]}|")
            }
            board_string.concat("\n")
        }
        board_string
    end

    def game_over?
        game_over=false
        @size.times{
            |x|
            cur_num = @board["#{x+1}x#{1}"]
            @size.times{
                |y|
                cur_tile= @board["#{x+1}x#{y+1}"]
                if cur_tile != cur_num || cur_num == @EMPTY
                    game_over=false
                    break
                else
                    game_over=true
                end
            }
            return game_over if game_over
        }
        @size.times{
            |x|
            cur_tile= @board["#{1}x#{1}"]
            if @board["#{x+1}x#{x+1}"] != cur_tile || @board["#{x+1}x#{x+1}"] == @EMPTY
                game_over=false
                break
            else
                game_over=true
            end
        }
        return game_over if game_over
        @size.times{
            |x|
            cur_num = @board["#{1}x#{@size}"]
            @size.times{
                |y|
                if x+y+2==@size+1
                    if @board["#{x+1}x#{y+1}"]==cur_num&&@board["#{x+1}x#{y+1}"]!=@EMPTY
                        game_over=true
                    else
                        game_over=false
                    end
                end
            }
        }
        game_over
    end
    def play?(player,tile)
        play_success=false
        if @board[tile]!=@EMPTY
            puts "Tile #{tile} is taken !"
        else
            if player==1
                @board[tile]=@PONE
                play_success=true
                return play_success
            elsif player==2
                @board[tile]=@PTWO
                play_success=true
                return play_success
            else
                p "Invalid value"
            end
        end
        play_success
    end
end
class Player
    def initialize
        @player1_win=0
        @player2_win=0
        @PLAYER_NUM=2
        @play_order=[1,2]
        @play_order=@play_order.shuffle
        if @play_order[0]==1
            p "Player 1 play first the player 2"
        else 
            p "Player 2 play first then player 1"
        end
    end
    public
    def current_player(cur_turn)
        return @play_order[cur_turn]
    end
end
p "Welcome to TicTacToe"
p "Player one uses X"
p "Player two uses O"
game_player = Player.new
game_board = Board.new
game_over=false
cur_turn=0
until game_over
    cur_player=game_player.current_player(cur_turn)
    turn_over=false
    until turn_over
        puts game_board
        puts "Player #{cur_player}, Enter your tile(Under the format 1x1):"
        tile_played= gets.chomp
        turn_over=game_board.play?(cur_player,tile_played)
    end
    game_over=game_board.game_over?
    if game_over
        puts game_board
        puts "Player #{cur_player} won!"
    else
        if cur_turn==0
            cur_turn += 1
        else
            cur_turn=0
        end
    end
end
