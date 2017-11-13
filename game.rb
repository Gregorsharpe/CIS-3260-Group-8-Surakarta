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
		game_board
		
		player_turn.select_move()
		
		#check if player has not lost
		
		player_turn = p2;
		
		
end