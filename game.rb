#/usr/bin/ruby

class Game

	# constructor
   	def initialize(s_limit, r_limit, p1, p2)
      @score_limit = s_limit
      @round_limit = r_limit
      @player1 = p1
	  @player2 = p2
	  @current_round=1
	  @player_turn = p1
   	end

   def end_Round(signal)
     @bypass = signal
    	if @bypass == true
    		@current_round++
			return
    	else
    		player.
    	end

	def round()
		$game_board = Board.new()


		#initialize the board
		@current_view = []
		@startPosition = [1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2]
		count = 0
		@startPosition.each do |x|
		@current_view << Space.new(count % 6, count/6, x)
		count = count + 1
end

		begin #start with player 1

			#decide what the player wants to do
			begin
				print "choose an option"
				print "1. Move
					   2. Capture
					   3. Forfiet
					   4. Quit  "

				@choice = gets.chomp

				case @choice
					when 1
						player_turn.select_move(game_board)
						break
					when 2
						player_turn.select_capture()
						break
					when 3
						player_turn.forfeit()
						break
					when 4
						player.quit()
						break
					else
						print "please select a valid move"

				end
			end while true




			#check if player has not lost



			change_turn()

		end while #add condition

	def remove_Piece(turn_player


	def Change_turn()
	if  @player_turn == p1
			@player_turn = p2
		else
			@player_turn =p1
		end
	end

end
